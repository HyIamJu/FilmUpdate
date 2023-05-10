import 'package:film_update_mobile_apps/models/movie_genre.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

  Future<void> getMovieByeGenrePagging(
      {required int genreId,
      required BuildContext context,
      required int pageKey,
      required PagingController pageControler}) async {
    try {
      final response =
          await tmdbServices.getMovieByGenre(idGenre: genreId, page: pageKey);

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
