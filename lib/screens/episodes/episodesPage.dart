import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/episode.dart';

class EpisodesPage extends StatefulWidget {
  final List<String> episodesIds;

  EpisodesPage({this.episodesIds});

  @override
  _EpisodesPageState createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  List<Episode> episodes = [];

  @override
  void initState() {
    super.initState();
    loadEpisodes(widget.episodesIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Episodes'),),
          body: ListView.builder(
        itemCount: episodes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(episodes[index].name),
            subtitle: Text(episodes[index].episode),
          );
        },
      ),
    );
  }

  loadEpisodes(List<String> idList) async {
    // final result =
    //     await RickAndMortyAPI().getMultipleEpisodes(episodesIds: idList);

    // final episodes = parseEpisodes(result);

    // setState(() {
    //   this.episodes = episodes;
    // });
  }

  List<Episode> parseEpisodes(String responseBody) {
    final jsonResults = json.decode(responseBody);

    var episodes =
        jsonResults.map<Episode>((json) => Episode.fromJson(json)).toList();
        
    return episodes;
  }
}
