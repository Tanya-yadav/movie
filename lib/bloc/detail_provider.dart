import 'package:flutter/material.dart';
import 'trailer.dart';
export 'trailer.dart';

class MovieDetailBlocProvider extends InheritedWidget {
  final MovieDetailBloc bloc;

  MovieDetailBlocProvider({Key key, Widget child})
      : bloc = MovieDetailBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static MovieDetailBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<MovieDetailBlocProvider>()
    as MovieDetailBlocProvider)
        .bloc;
  }}

class MoviesBloc {
}
  final bloc = MovieDetailBloc();
