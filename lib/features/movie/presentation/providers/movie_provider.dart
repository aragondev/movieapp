import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_app/features/movie/domain/usecases/get_movie_by_id.dart';
import 'package:movie_app/features/movie/domain/usecases/get_movies.dart';

// Proveedor para DioClient
final dioProvider = Provider((ref) => DioClient());

// Proveedor para la fuente de datos remota de películas
final movieRemoteDataSourceProvider = Provider<MovieRemoteDataSource>(
  (ref) => MovieRemoteDataSourceImpl(dioClient: ref.watch(dioProvider)),
);

// Proveedor para el repositorio de películas
final movieRepositoryProvider = Provider<MovieRepository>(
  (ref) => MovieRepositoryImpl(
      remoteDataSource: ref.watch(movieRemoteDataSourceProvider)),
);

// Proveedor para el caso de uso de obtener todas las películas
final getMoviesProvider = Provider<GetMovies>(
  (ref) => GetMovies(repository: ref.watch(movieRepositoryProvider)),
);

// Proveedor para el caso de uso de obtener una película por su ID
final getMovieByIdProvider = Provider<GetMovieById>(
  (ref) => GetMovieById(repository: ref.watch(movieRepositoryProvider)),
);

// Proveedor para la lista de todas las películas
final moviesProvider = FutureProvider<List<Movie>>((ref) async {
  return await ref.watch(getMoviesProvider).call();
});

// Proveedor para obtener una película específica por ID
final movieProvider = FutureProvider.family<Movie, int>((ref, movieId) async {
  return await ref.watch(getMovieByIdProvider).call(movieId);
});

// Proveedor para alternar entre vista clásica y vista de grid
final viewModeProvider =
    StateProvider<bool>((ref) => false); // false = clásico, true = grid