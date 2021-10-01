import 'dart:async';

import 'package:cinemo/model/trailer_model.dart';

import 'package:http/http.dart' show Client;
import 'dart:convert';

class MovieApiProvider{
  Client client = Client();
  final _apiKey = "f55fbda0cb73b855629e676e54ab6d8e";
  final _baseURL = "http://api.themoviedb.org/3/movie";


  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response = await client
        .get("$_baseURL/$movieId/videos?api_key=$_apiKey");

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}