import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/screens/episodes/episodesPage.dart';

class CharacterDetails extends StatelessWidget {
  final Character character;

  CharacterDetails({this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250.0,
            child: SizedBox.expand(
              child: FittedBox(
                child: Image.network(character.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Text(character.name, style: TextStyle(fontSize: 40.0)),
          ),
          Divider(
            color: Colors.grey,
            indent: 16.0,
          ),
          ListTile(
            title: Text('Species'),
            subtitle: Text(character.species),
          ),
          ListTile(
            title: Text('Gender'),
            subtitle: Text(character.gender),
          ),
          ListTile(
            title: Text('Status'),
            subtitle: Text(character.status),
          ),
          ListTile(
            title: Text(
              'Episodes',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            trailing: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8.0,
              children: <Widget>[
                Text('See details'),
                Icon(Icons.info_outline)
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => EpisodesPage(
                        
                        episodesIds: character.episodes.toList().map((f) {
                          return f.split("/").last;
                        }).toList()
                      ),
                      fullscreenDialog: true));
            },
          ),
          ListTile(
            title: Text('Origin'),
            trailing: Text(character.origin.name),
          ),
          ListTile(
            title: Text('Last location'),
            trailing: Text(character.location.name),
          )
        ],
      ),
    );
  }
}
