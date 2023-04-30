import 'package:film_update_mobile_apps/models/movie_model.dart';
import 'package:film_update_mobile_apps/services/services_tmdb.dart';
import 'package:flutter/material.dart';
import '../../utils/finite_state.dart';

class GetPopularMovieProvider extends ChangeNotifier {
  final List<MovieModel> _movies = [];

  List<MovieModel> get getMovies => _movies;
  final tmdbServices = ServicesTmdb();
  MyState state = MyState.loading;

  int get movieLength => _movies.length;

  void getPopularMovieData() async {
    try {
      // state = MyState.loading;
      // notifyListeners();

      final response = await tmdbServices.getMoviePopular();
      _movies.addAll(response.results);

      // print(response.totalPages);

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }
}
