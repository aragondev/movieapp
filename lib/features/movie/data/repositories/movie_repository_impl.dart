import 'package:movie_app/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getAllMovies() async {
    return await remoteDataSource.getMovies();
  }

  @override
  Future<Movie> getMovieById(int id) async {
    return await remoteDataSource.getMovieById(id);
  }
}
