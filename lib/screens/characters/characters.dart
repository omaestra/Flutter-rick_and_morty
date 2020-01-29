import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/api_response.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/services/api.dart';
import 'package:rick_and_morty/widgets/searchBar.dart';
import 'characterRowItem.dart';

class Characters extends StatefulWidget {
  @override
  _CharactersState createState() => _CharactersState();
}

class _CharactersState extends State<Characters> {
  List<Character> characters = [];
  List<Character> filteredCharacters = List<Character>();

  int page = 1;
  bool isLoading = false;
  bool isSearching = false;

  ScrollController _scrollController;
  TextEditingController _textEditingController;
  FocusNode _focusNode;
  String _terms = "";

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    loadCharacters();
    _textEditingController = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var results = isSearching ? this.filteredCharacters : this.characters;
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchBox(),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: results.length,
        itemBuilder: (context, index) {
          if (index == results.length - 1) {
            return _buildProgressIndicator(); 
          } else {
            return CharacterRowItem(
              index: index,
              character: results[index],
              isLastItem: index == results.length - 1,
            );
          }
        },
      ),
    );
  }

  loadCharacters() async {
    setState(() {
      this.isLoading = true;
    });

    var result = await RickAndMortyAPI().getCharacters();
    setState(() {
      this.characters = [];
    });
    setState(() {
      this.isLoading = false;
      this.characters = parseCharacters(result);
    });
  }

  void loadMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      final page = this.page + 1;
      final result = await RickAndMortyAPI().getCharacters(page: page);
      final characters = parseCharacters(result);

      setState(() {
        this.page = page;
        this
            .characters
            .addAll(characters.where((c) => !this.characters.contains(c)));
        isLoading = false;
      });
    }
  }

  void searchCharacter(String searchTerms) async {
    if (searchTerms.isEmpty) {
        setState(() {
          this.filteredCharacters = this.characters;
          this.isSearching = false;
        });
      } else {
        final result =
            await RickAndMortyAPI().searchCharacter(searchTerms: searchTerms);

        setState(() {
          this.filteredCharacters = result != null ? parseCharacters(result) : [];
          this.isSearching = true;
        });
      }
  }

  // A function that converts a response body into a List<Character>.
  List<Character> parseCharacters(String responseBody) {
    final jsonResults = json.decode(responseBody);
    final apiResponse = ApiResponse.fromJson(jsonResults);

    return apiResponse.results
        .map<Character>((json) => Character.fromJson(json))
        .toList();
  }

  // Search the product catalog
  List<Character> search(String searchTerms) {
    return this.characters.where((character) {
      return character.name.toLowerCase().contains(searchTerms.toLowerCase());
    }).toList();
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      loadMore();
    }
  }

  _onTextChanged() {
    setState(() {
      _terms = _textEditingController.text;
    });

    searchCharacter(_terms);
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: _textEditingController,
        focusNode: _focusNode,
      ),
    );
  }
}
