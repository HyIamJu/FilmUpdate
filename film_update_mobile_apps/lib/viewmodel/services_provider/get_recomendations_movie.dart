import 'package:film_update_mobile_apps/models/movie_model.dart';
import 'package:film_update_mobile_apps/services/services_tmdb.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../utils/finite_state.dart';

class GetRecomendationMovieProvider extends ChangeNotifier {
  final List<MovieModel> _movies = [];

  List<MovieModel> get getMovies => _movies;

  int get movieLength => _movies.length;

  final tmdbServices = ServicesTmdb();

  MyState state = MyState.loading;

  void getRecomendationMovieData({required int movieId, int page = 1}) async {
    _movies.clear();
    try {
      final response = await tmdbServices.getMovieRecomendations(
          movieId: movieId, page: page);
      _movies.addAll(response.results!);

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }

  Future<void> getRecomendationWithPagging(
      {required int movieId,
      required BuildContext context,
      required int pageKey,
      required PagingController pageControler}) async {
    try {
      final response = await tmdbServices.getMovieRecomendations(
          movieId: movieId, page: pageKey);

      if (response.results!.length < 20) {
        pageControler.appendLastPage(response.results!);
      } else {
        pageControler.appendPage(response.results!, pageKey + 1);
      }
    } catch (error) {
      pageControler.error = error;
    }
  }
}
