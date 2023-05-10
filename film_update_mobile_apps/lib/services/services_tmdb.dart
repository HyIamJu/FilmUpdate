import 'package:dio/dio.dart';
import 'package:film_update_mobile_apps/models/configuration_language.dart';
import 'package:film_update_mobile_apps/models/movie_credits.dart';
import 'package:film_update_mobile_apps/models/movie_genre.dart';
import 'package:film_update_mobile_apps/models/movie_videos.dart';
import 'package:film_update_mobile_apps/utils/app_constant.dart';

import '../models/movie_details.dart';
import '../models/movie_model.dart';

class ServicesTmdb {
  //--singleton--
  static final ServicesTmdb _instance = ServicesTmdb._internal();
  ServicesTmdb._internal();
  factory ServicesTmdb() {
    return _instance;
  }

  //-- dio initialize--
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: AppConstant.baseUrl,
        queryParameters: {'api_key': AppConstant.apiKey}),
  );

  //--method--

  Future<List<LanguangeModel>> getLanguage() async {
    try {
      List<LanguangeModel> language = [];
      final response = await _dio.get(
        '/configuration/languages',
      );

      for (var value in response.data) {
        language.add(LanguangeModel.fromJson(value));
      }

      return language;

      // return model;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GenreModelResponse> getAllGenreMovie({String language = "en"}) async {
    try {
      final response = await _dio.get(
        '/genre/movie/list',
        queryParameters: {'language': language},
      );
      final model = GenreModelResponse.fromJson(response.data);
      return model;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieModelResponse> getMovieByGenre(
      {int page = 3, required int idGenre}) async {
    try {
      final response = await _dio.get(
        '/discover/movie',
        queryParameters: {
          'page': page,
          'with_genres': idGenre.toString(),
        },
      );

      final model = MovieModelResponse.fromJson(response.data);

      return model;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieModelResponse> getMovieDiscover({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/discover/movie',
        queryParameters: {
          'page': page,
        },
      );

      final model = MovieModelResponse.fromJson(response.data);

      return model;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieModelResponse> getMovieNowPlaying({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );

      final model = MovieModelResponse.fromJson(response.data);

      return model;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieModelResponse> getMoviePopular({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );

      final model = MovieModelResponse.fromJson(response.data);

      return model;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieModelResponse> getMovieUpComing({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/upcoming',
        queryParameters: {
          'page': page,
          'region': 'US',
        },
      );

      final model = MovieModelResponse.fromJson(response.data);

      return model;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieModelResponse> getSearchMovie(
      {int page = 1, required String query}) async {
    try {
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {
          'page': page,
          'query': query,
        },
      );

      final model = MovieModelResponse.fromJson(response.data);

      return model;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieDetailsResponse> getMovieDetails({required int movieId}) async {
    try {
      final response = await _dio.get(
        '/movie/$movieId',
        // queryParameters: {
        //   'movie_id': movieId,
        // },
      );

      final model = MovieDetailsResponse.fromJson(response.data);

      return model;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<MovieCastModel>> getMovieCredits({required int movieId}) async {
    try {
      List<MovieCastModel> cast = [];
      final response = await _dio.get(
        '/movie/$movieId/credits',
      );

      for (var value in response.data["cast"]) {
        cast.add(MovieCastModel.fromJson(value));
      }

      return cast;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieVideosResponse> getMovieVideos({required int movieId}) async {
    try {
      final response = await _dio.get(
        '/movie/$movieId/videos',
      );
      final model = MovieVideosResponse.fromJson(response.data);
      return model;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieModelResponse> getMovieRecomendations(
      {required int movieId, int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/$movieId/recommendations',
        queryParameters: {
          'page': page,
        },
      );
      final model = MovieModelResponse.fromJson(response.data);
      return model;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }
}
