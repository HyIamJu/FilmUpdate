class FavoriteMovieModel {
  int? id;
  int? idMovie;
  String? titleMovie;
  String? posterPathMovie;
  String? dateMovie;

  FavoriteMovieModel({
    this.id,
    this.idMovie,
    this.titleMovie,
    this.posterPathMovie,
    this.dateMovie,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "id_movie": idMovie,
      "title_movie": titleMovie,
      "poster_path_movie": posterPathMovie,
      "date_movie": dateMovie,
    };
  }

  FavoriteMovieModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    idMovie = map["id_movie"];
    titleMovie = map["title_movie"];
    posterPathMovie = map["poster_path_movie"];
    dateMovie = map["date_movie"];
  }
}
