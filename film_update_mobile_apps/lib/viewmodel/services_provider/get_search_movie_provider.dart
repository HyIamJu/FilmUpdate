import 'package:flutter/material.dart';

import '../../models/movie_model.dart';
import '../../services/services_tmdb.dart';
import '../../utils/finite_state.dart';

class GetSearchMovieProvider extends ChangeNotifier {
  final List<MovieModel> _movies = [];

  List<MovieModel> get getMovies => _movies;

  int get movieLength => _movies.length;

  final tmdbServices = ServicesTmdb();

  MyState state = MyState.initial;

  void getSearchMovieData({required String query, int page = 1}) async {
    state = MyState.loading;
    notifyListeners();

    _movies.clear();
    // notifyListeners();

    try {
      final response =
          await tmdbServices.getSearchMovie(query: query, page: page);
      _movies.addAll(response.results!);

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }
}
