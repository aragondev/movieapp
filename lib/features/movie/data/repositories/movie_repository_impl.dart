// Implementación del repositorio de películas.
import 'package:movie_app/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_repository.dart';

/// Este repositorio actúa como un intermediario entre la capa de datos y la capa de dominio.
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getAllMovies() async {
    return await remoteDataSource
        .getAllMovies(); // Obtiene todas las películas del datasource remoto
  }

  @override
  Future<Movie> getMovieById(int id) async {
    return await remoteDataSource
        .getMovieById(id); // Obtiene una película por ID
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    return await remoteDataSource
        .searchMovies(query); // Busca películas por título
  }
}
