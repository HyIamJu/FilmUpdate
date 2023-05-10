// To parse this JSON data, do
//
//     final movieDetails = movieDetailsFromJson(jsonString);

import 'dart:convert';

MovieDetailsResponse movieDetailsFromJson(String str) =>
    MovieDetailsResponse.fromJson(json.decode(str));

String movieDetailsToJson(MovieDetailsResponse data) =>
    json.encode(data.toJson());

class MovieDetailsResponse {
  bool adult;
  String? backdropPath;
  int budget;
  List<Genre> genres;
  String? homepage;
  int id;
  String originalLanguage;
  String originalTitle;
  String? overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  int revenue;
  int? runtime;
  String status;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetailsResponse({
    required this.adult,
    this.backdropPath,
    required this.budget,
    required this.genres,
    this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.revenue,
    this.runtime,
    required this.status,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailsResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        budget: json["budget"],
        // genres
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        revenue: json["revenue"],
        runtime: json["runtime"],
        status: json["status"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "budget": budget,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "revenue": revenue,
        "runtime": runtime,
        "status": status,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class BelongsToCollection {
  int id;
  String name;
  String posterPath;
  String backdropPath;

  BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      BelongsToCollection(
        id: json["id"],
        name: json["name"],
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
      };
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  List<Genre> parseGenre(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Genre>((json) => Genre.fromJson(json)).toList();
  }
}
