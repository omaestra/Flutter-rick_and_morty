import 'package:rick_and_morty/services/network.dart';

const String apiURL = 'https://rickandmortyapi.com/api';

class RickAndMortyAPI {
  Future<dynamic> getCharacters() async {
    Network network = Network('$apiURL/character');

    var data = await network.getData();
    
    return data;
  }
}