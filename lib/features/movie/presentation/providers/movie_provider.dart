import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_app/features/movie/domain/usecases/get_movies.dart';

final dioProvider = Provider((ref) => DioClient());

final movieRemoteDataSourceProvider = Provider<MovieRemoteDataSource>(
  (ref) => MovieRemoteDataSourceImpl(dioClient: ref.watch(dioProvider)),
);

final movieRepositoryProvider = Provider<MovieRepository>(
  (ref) => MovieRepositoryImpl(
      remoteDataSource: ref.watch(movieRemoteDataSourceProvider)),
);

final getMoviesProvider = Provider<GetMovies>(
  (ref) => GetMovies(repository: ref.watch(movieRepositoryProvider)),
);

final moviesProvider = FutureProvider<List<Movie>>((ref) async {
  return await ref.watch(getMoviesProvider).call();
});

final viewModeProvider =
    StateProvider<bool>((ref) => false); // false = clásico, true = grid