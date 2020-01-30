import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/utilities/exceptions.dart';

class RickAndMortyAPI {
  final String apiURL = 'https://rickandmortyapi.com/api';

  Future<dynamic> get(String url) async {
    var responseJson;

    print("[INFO]: GET REQUEST to URL: $url");
    try {
      final response = await http.get(apiURL + url);

      responseJson = _response(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print("[INFO]: GET RESPONSE to URL: ${response.statusCode}");
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
