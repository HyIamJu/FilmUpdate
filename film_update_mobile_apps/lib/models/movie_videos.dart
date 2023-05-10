// To parse this JSON data, do
//
//     final movieVideos = movieVideosFromJson(jsonString);

import 'dart:convert';

MovieVideosResponse movieVideosFromJson(String str) =>
    MovieVideosResponse.fromJson(json.decode(str));

String movieVideosToJson(MovieVideosResponse data) =>
    json.encode(data.toJson());

class MovieVideosResponse {
  int id;
  List<MovieVideos> results;

  MovieVideosResponse({
    required this.id,
    required this.results,
  });

  factory MovieVideosResponse.fromJson(Map<String, dynamic> json) =>
      MovieVideosResponse(
        id: json["id"],
        results: List<MovieVideos>.from(
            json["results"].map((x) => MovieVideos.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class MovieVideos {
  String iso6391;
  String iso31661;
  String name;
  String key;
  String site;
  int size;
  String type;
  bool official;
  DateTime publishedAt;
  String id;

  MovieVideos({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory MovieVideos.fromJson(Map<String, dynamic> json) => MovieVideos(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        "published_at": publishedAt.toIso8601String(),
        "id": id,
      };
}
