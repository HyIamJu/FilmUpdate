import 'package:film_update_mobile_apps/models/movie_videos.dart';
import 'package:flutter/material.dart';

import '../../services/services_tmdb.dart';
import '../../utils/finite_state.dart';

class GetVideosMovieProvider extends ChangeNotifier {
  final List<MovieVideos> _movieVideos = [];

  List<MovieVideos> get getMovieVideos => _movieVideos;

  get getMovieVideosLength => _movieVideos.length;

  final tmdbServices = ServicesTmdb();

  MyState state = MyState.loading;

  void getVideosMovieData({required int movieId}) async {
    try {
      _movieVideos.clear();
      final response = await tmdbServices.getMovieVideos(movieId: movieId);

      for (var element in response.results) {
        if (element.type == "Trailer") {
          _movieVideos.add(element);
        }
      }

      if (_movieVideos.isEmpty) {
        for (var element in response.results) {
          _movieVideos.add(element);
        }
      }

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }
}
