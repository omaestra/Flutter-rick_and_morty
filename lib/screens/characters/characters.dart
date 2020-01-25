import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/services/api.dart';
import 'package:rick_and_morty/utilities/styles.dart';

class Characters extends StatefulWidget {
  @override
  _CharactersState createState() => _CharactersState();
}

class _CharactersState extends State<Characters> {
  List characters = [];

  @override
  void initState() {
    super.initState();

    loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (context, index) {
          return SafeArea(
            top: false,
            bottom: false,
            minimum: const EdgeInsets.only(
              left: 16,
              top: 8,
              bottom: 8,
              right: 8,
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    '${characters[index].image}',
                    fit: BoxFit.cover,
                    width: 76,
                    height: 76,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${characters[index].name}',
                          style: Styles.characterRowItemName,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        Text(
                          '${characters[index].status}',
                          style: Styles.characterRowItemStatus,
                        )
                      ],
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // final model = Provider.of<AppStateModel>(context);
                    // model.addProductToCart(product.id);
                  },
                  child: const Icon(
                    CupertinoIcons.plus_circled,
                    semanticLabel: 'Add',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  loadCharacters() async {
    var result = await RickAndMortyAPI().getCharacters();
    var characters = parseCharacters(result);

    setState(() {
      this.characters = characters;
    });
  }

  // A function that converts a response body into a List<Character>.
  List<Character> parseCharacters(String responseBody) {
    final jsonResults = json.decode(responseBody)['results'];
    final parsed = jsonResults.cast<Map<String, dynamic>>();

    return parsed.map<Character>((json) => Character.fromJson(json)).toList();
  }
}
