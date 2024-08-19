class Movie {
  final int id;
  final String title;
  final int year;
  final List<String> genre;
  final double rating;
  final String director;
  final List<String> actors;
  final String plot;
  final String poster;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.genre,
    required this.rating,
    required this.director,
    required this.actors,
    required this.plot,
    required this.poster,
  });
}
