import 'package:film_update_mobile_apps/models/movie_genre.dart';
import 'package:flutter/material.dart';

import '../../services/services_tmdb.dart';
import '../../utils/finite_state.dart';

class GetGenreMovieProvider extends ChangeNotifier {
  List<GenreModel> genre = [];
  final tmdbServices = ServicesTmdb();
  MyState state = MyState.loading;

  Future<void> getAllGenreList() async {
    try {
      final response = await tmdbServices.getAllGenreMovie();
      genre = response.genres;
      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }
}
