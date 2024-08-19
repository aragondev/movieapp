import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_repository.dart';

class GetMovieById {
  final MovieRepository repository;

  GetMovieById({required this.repository});

  Future<Movie> call(int id) async {
    return await repository.getMovieById(id);
  }
}
