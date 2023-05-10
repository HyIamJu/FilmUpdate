// // To parse this JSON data, do
// //
// //     final movieModelResponse = movieModelResponseFromJson(jsonString);

// import 'dart:convert';

// MovieModelResponse movieModelResponseFromJson(String str) =>
//     MovieModelResponse.fromJson(json.decode(str));

// String movieModelResponseToJson(MovieModelResponse data) =>
//     json.encode(data.toJson());

// class MovieModelResponse {
//   int page;
//   List<MovieModel> results;
//   int totalPages;
//   int totalResults;

//   MovieModelResponse({
//     required this.page,
//     required this.results,
//     required this.totalPages,
//     required this.totalResults,
//   });

//   factory MovieModelResponse.fromJson(Map<String, dynamic> json) =>
//       MovieModelResponse(
//         page: json["page"],
//         results: List<MovieModel>.from(
//             json["results"].map((x) => MovieModel.fromJson(x))),
//         totalPages: json["total_pages"],
//         totalResults: json["total_results"],
//       );

//   Map<String, dynamic> toJson() => {
//         "page": page,
//         "results": List<dynamic>.from(results.map((x) => x.toJson())),
//         "total_pages": totalPages,
//         "total_results": totalResults,
//       };

//   List<MovieModel> resultList(Map<String, dynamic> json) {
//     List<MovieModel> result = [];

//     for (var element in json["results"]) {
//       results.add(MovieModel.fromJson(element));
//     }

//     return result;
//   }
// }

// class MovieModel {
//   String? backdropPath;

//   int? id;
//   String? originalLanguage;
//   String? originalTitle;
//   String? overview;
//   double? popularity;
//   String? posterPath;
//   String? releaseDate;
//   String? title;

//   double? voteAverage;
//   int? voteCount;

//   MovieModel({
//     this.backdropPath,
//     this.id,
//     this.originalLanguage,
//     this.originalTitle,
//     this.overview,
//     this.popularity,
//     this.posterPath,
//     this.releaseDate,
//     this.title,
//     this.voteAverage,
//     this.voteCount,
//   });

//   factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
//         backdropPath: json["backdrop_path"],
//         id: json["id"],
//         originalLanguage: json["original_language"]!,
//         originalTitle: json["original_title"],
//         overview: json["overview"],
//         popularity: json["popularity"]?.toDouble(),
//         posterPath: json["poster_path"],
//         releaseDate: json["release_date"],
//         title: json["title"],
//         voteAverage: json["vote_average"]?.toDouble(),
//         voteCount: json["vote_count"],
//       );

//   Map<String, dynamic> toJson() => {
//         "backdrop_path": backdropPath,
//         "id": id,
//         "original_language": originalLanguage,
//         "original_title": originalTitle,
//         "overview": overview,
//         "popularity": popularity,
//         "poster_path": posterPath,
//         "release_date": releaseDate,
//         "title": title,
//         "vote_average": voteAverage,
//         "vote_count": voteCount,
//       };
// }
// To parse this JSON data, do
//
//     final movieModelResponse = movieModelResponseFromJson(jsonString);

import 'dart:convert';

MovieModelResponse movieModelResponseFromJson(String str) =>
    MovieModelResponse.fromJson(json.decode(str));

String movieModelResponseToJson(MovieModelResponse data) =>
    json.encode(data.toJson());

class MovieModelResponse {
  int? page;
  List<MovieModel>? results;
  int? totalPages;
  int? totalResults;

  MovieModelResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieModelResponse.fromJson(Map<String, dynamic> json) =>
      MovieModelResponse(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<MovieModel>.from(
                json["results"]!.map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class MovieModel {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
