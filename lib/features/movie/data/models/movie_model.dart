import 'package:movie_app/features/movie/domain/entities/movie.dart';

/// MovieModel es la implementación concreta de la entidad Movie.
/// Representa un modelo que mapea los datos JSON obtenidos desde la API.
class MovieModel extends Movie {
  MovieModel({
    required int id,
    required String title,
    required int year,
    required List<String> genre,
    required double rating,
    required String director,
    required List<String> actors,
    required String plot,
    required String poster,
    required String trailer,
    required int runtime,
    required String awards,
    required String country,
    required String language,
    required String boxOffice,
    required String production,
    required String website,
  }) : super(
          id: id,
          title: title,
          year: year,
          genre: genre,
          rating: rating,
          director: director,
          actors: actors,
          plot: plot,
          poster: poster,
          trailer: trailer,
          runtime: runtime,
          awards: awards,
          country: country,
          language: language,
          boxOffice: boxOffice,
          production: production,
          website: website,
        );

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
      plot: json['plot'],
      poster: json['poster'],
      trailer: json['trailer'],
      runtime: json['runtime'],
      awards: json['awards'],
      country: json['country'],
      language: json['language'],
      boxOffice: json['boxOffice'],
      production: json['production'],
      website: json['website'],
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
