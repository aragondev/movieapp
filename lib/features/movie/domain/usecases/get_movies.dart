import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_repository.dart';

/// Caso de uso para obtener todas las películas.
/// Esta clase interactúa con el repositorio para recuperar la lista de películas.
class GetMovies {
  final MovieRepository repository;

  GetMovies({required this.repository});

  Future<List<Movie>> call() async {
    return await repository.getAllMovies();
  }
}
