import 'package:flutter/material.dart';

import '../../models/movie_credits.dart';
import '../../services/services_tmdb.dart';
import '../../utils/finite_state.dart';

class GetTopCastProvider extends ChangeNotifier {
  final List<MovieCastModel> _cast = [];

  List<MovieCastModel> get getCast => _cast;

  get getCastLength => _cast.length;

  final tmdbServices = ServicesTmdb();

  MyState state = MyState.loading;

  void getTopCastData({required int movieId}) async {
    try {
      state = MyState.loading;
      _cast.clear();
      final response = await tmdbServices.getMovieCredits(movieId: movieId);

      if (response.isNotEmpty) {
        _cast.addAll(response);
        state = MyState.loaded;
        notifyListeners();
      }

      if (response.isEmpty) {
        state = MyState.loaded;
        notifyListeners();
      }
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }
}
