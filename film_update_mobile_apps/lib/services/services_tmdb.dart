import 'package:dio/dio.dart';
import 'package:film_update_mobile_apps/models/movie_genre.dart';
import 'package:film_update_mobile_apps/utils/app_constant.dart';

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

  Future<MovieModelResponse> getMovieDiscover({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
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

  Future<MovieModelResponse> getTopRated({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );

      final model = MovieModelResponse.fromJson(response.data);

      return model;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }
}
