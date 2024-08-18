import 'package:movie_app/features/movie/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.year,
    required super.genre,
    required super.rating,
    required super.director,
    required super.actors, // Cambiado para ser una lista de ActorModel
    required super.plot,
    required super.poster,
    required super.trailer,
    required super.runtime,
    required super.awards,
    required super.country,
    required super.language,
    required super.boxOffice,
    required super.production,
    required super.website,
  });

  /// Convierte un mapa JSON en una instancia de MovieModel.
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      genre: List<String>.from(json['genre']),
      rating: json['rating'].toDouble(),
      director: json['director'],
      actors: List<String>.from(json['actors']),
      poster: json['poster'],
      trailer: json['trailer'],
      runtime: json['runtime'],
      awards: json['awards'],
      country: json['country'],
      language: json['language'],
      boxOffice: json['boxOffice'],
      production: json['production'],
      website: json['website'],
      plot: json['plot'],
    );
  }

  /// Convierte la instancia de MovieModel a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'genre': genre,
      'rating': rating,
      'director': director,
      'actors': actors,
      'plot': plot,
      'poster': poster,
      'trailer': trailer,
      'runtime': runtime,
      'awards': awards,
      'country': country,
      'language': language,
      'boxOffice': boxOffice,
      'production': production,
      'website': website,
    };
  }
}
