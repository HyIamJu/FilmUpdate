// To parse this JSON data, do
//
//     final genre = genreFromJson(jsonString);

import 'dart:convert';

GenreModelResponse genreFromJson(String str) =>
    GenreModelResponse.fromJson(json.decode(str));

String genreToJson(GenreModelResponse data) => json.encode(data.toJson());

class GenreModelResponse {
  List<GenreModel> genres;

  GenreModelResponse({
    required this.genres,
  });

  factory GenreModelResponse.fromJson(Map<String, dynamic> json) =>
      GenreModelResponse(
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };
}

class GenreModel {
  int id;
  String name;

  GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
