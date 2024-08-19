import 'package:movie_app/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getAllMovies() async {
    return await remoteDataSource.getAllMovies();
  }

  @override
  Future<Movie> getMovieById(int id) async {
    return await remoteDataSource.getMovieById(id);
  }

  Future<List<Movie>> getMoviesWithLimit(int limit) async {
    return await remoteDataSource.getMoviesWithLimit(limit);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    return await remoteDataSource.searchMovies(query);
  }

  Future<List<Movie>> sortMoviesByName({String order = 'asc'}) async {
    return await remoteDataSource.sortMoviesByName(order: order);
  }
}
