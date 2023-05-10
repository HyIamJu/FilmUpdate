import 'package:film_update_mobile_apps/models/movie_details.dart';
import 'package:flutter/material.dart';

import '../../services/services_tmdb.dart';
import '../../utils/finite_state.dart';

class GetDetailsMovieProvider extends ChangeNotifier {
  final tmdbServices = ServicesTmdb();
  MyState state = MyState.initial;

  MovieDetailsResponse? _details;

  MovieDetailsResponse get getDetails => _details!;

  void getDetailsMovieData({required int movieId}) async {
    try {
      state = MyState.loading;
      final response = await tmdbServices.getMovieDetails(movieId: movieId);
      _details = response;

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;

      notifyListeners();
    }
  }

  String getGenres() {
    String allGenre = "";
    if (_details!.genres.isNotEmpty) {
      for (var i = 0; i < _details!.genres.length; i++) {
        if (i + 1 != _details!.genres.length) {
          allGenre += "${_details!.genres[i].name}, ";
        } else {
          allGenre += _details!.genres[i].name;
        }
      }
      return allGenre;
    }

    return allGenre;
  }
}
