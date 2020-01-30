import 'package:rick_and_morty/models/api_response.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/services/api.dart';

class CharacterService {
  RickAndMortyAPI _apiProvider = RickAndMortyAPI();

  Future<ApiResponse> getCharacters({int page}) async {
    final response = await _apiProvider.get("/character?page=$page");

    return ApiResponse.fromJson(response);
  }

  Future<List<Character>> searchCharacter({String searchTerms}) async {
    final response = await _apiProvider.get("/character?name=$searchTerms");

    return ApiResponse.fromJson(response).results
        .map<Character>((json) => Character.fromJson(json))
        .toList();
  }
}