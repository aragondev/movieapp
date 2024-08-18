import 'package:movie_app/features/movie/domain/entities/movie.dart';

/// Interfaz que define los métodos que deben implementar los repositorios de películas.
abstract class MovieRepository {
  Future<List<Movie>> getAllMovies(); // Método para obtener todas las películas
  Future<Movie> getMovieById(int id); // Método para obtener una película por ID
  Future<List<Movie>> searchMovies(
      String query); // Método para buscar películas por título
}
