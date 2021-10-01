import 'dart:async';


import 'package:cinemo/model/trailer_model.dart';

import 'package:cinemo/resources/api_provider.dart';

class Repository{
  final movieApiProvider = MovieApiProvider();


  Future<TrailerModel> fetchTrailers(int movieId) => movieApiProvider.fetchTrailer(movieId);
}