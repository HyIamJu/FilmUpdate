// To parse this JSON data, do
//
//     final languangeModel = languangeModelFromJson(jsonString);

import 'dart:convert';

LanguangeModel languangeModelFromJson(String str) =>
    LanguangeModel.fromJson(json.decode(str));

String languangeModelToJson(LanguangeModel data) => json.encode(data.toJson());

class LanguangeModel {
  String? iso6391;
  String? englishName;
  String? name;

  LanguangeModel({
    this.iso6391,
    this.englishName,
    this.name,
  });

  factory LanguangeModel.fromJson(Map<String, dynamic> json) => LanguangeModel(
        iso6391: json["iso_639_1"],
        englishName: json["english_name"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391,
        "english_name": englishName,
        "name": name,
      };
}
