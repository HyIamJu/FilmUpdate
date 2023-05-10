import 'package:film_update_mobile_apps/models/favorite_movie.dart';
import 'package:film_update_mobile_apps/services/service_local_db_helper.dart';
import 'package:flutter/foundation.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  List<FavoriteMovieModel> _favoriteModels = [];

  List<FavoriteMovieModel> get favoriteModels => _favoriteModels;
  int get favoriteLength => _favoriteModels.length;

  void getAllFavorite() async {
    try {
      final results = await LocalDatabaseService.instance.getFavorite();
      _favoriteModels = results;
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addFavorite(FavoriteMovieModel favModel) async {
    try {
      await LocalDatabaseService.instance.insertFavorite(favModel);
      getAllFavorite();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteFavorite(int movieId) async {
    try {
      await LocalDatabaseService.instance.deleteFavorite(movieId);
      getAllFavorite();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  bool isContainThisId(int movieId) {
    for (var value in _favoriteModels) {
      if (value.idMovie == movieId) {
        return true;
      }
    }
    return false;
  }

  int reverseIndex(int curentIndex) {
    int reverse = _favoriteModels.length - curentIndex;
    return reverse;
  }
}
