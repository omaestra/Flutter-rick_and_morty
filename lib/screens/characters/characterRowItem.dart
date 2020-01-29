import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/screens/characters/characterDetails.dart';
import 'package:rick_and_morty/utilities/styles.dart';

class CharacterRowItem extends StatelessWidget {
  final int index;
  final Character character;
  final bool isLastItem;

  CharacterRowItem({this.index, this.character, this.isLastItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
      title: Text(
        "${character.name}",
        style: Styles.characterRowItemName,
      ),
      subtitle: Text(character.status),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          '${character.image}',
          fit: BoxFit.cover,
          width: 76,
          height: 76,
        ),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CharacterDetails(
                      character: character,
                    )));
      },
    );
  }
}
