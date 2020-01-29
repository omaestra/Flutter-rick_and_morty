import 'package:rick_and_morty/services/network.dart';

const String apiURL = 'https://rickandmortyapi.com/api';

class RickAndMortyAPI {
  Future<dynamic> getCharacters({int page}) async {
    Network network = Network(page == null ? '$apiURL/character' : '$apiURL/character?page=$page');

    final data = await network.getData();
    
    return data;
  }

  Future<dynamic> searchCharacter({String searchTerms}) async {
    Network network = Network('$apiURL/character?name=$searchTerms');

    final data = await network.getData();

    return data;
  }

  Future<dynamic> getMultipleEpisodes({List<String> episodesIds}) async {
    Network network = Network('$apiURL/episode/$episodesIds');

    final data = await network.getData();

    return data;
  }
}