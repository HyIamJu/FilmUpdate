import 'package:film_update_mobile_apps/models/movie_model.dart';
import 'package:film_update_mobile_apps/services/services_tmdb.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../utils/finite_state.dart';

class GetDiscoverMovieProvider extends ChangeNotifier {
  final List<MovieModel> _movies = [];
  final List<MovieModel> _moviesWithPagging = [];

  List<MovieModel> get getMovies => _movies;
  List<MovieModel> get getMoviesWithPagging => _movies;

  int get movieLength => _movies.length;
  int get moviesWithPaggingLength => _moviesWithPagging.length;

  final tmdbServices = ServicesTmdb();
  MyState state = MyState.loading;

  void getDiscoverMovieData() async {
    try {
      // state = MyState.loading;
      // notifyListeners();
      _movies.clear();
      final response = await tmdbServices.getMovieDiscover();

      _movies.addAll(response.results!);

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }

  Future<void> getDiscoverWithPagging(
      {required BuildContext context,
      required int pageKey,
      required PagingController pageControler}) async {
    try {
      final response = await tmdbServices.getMovieDiscover(page: pageKey);

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
