import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/features/movie/domain/usecases/get_movies.dart';

/// Proveedor de DioClient que proporciona la configuración de Dio para hacer solicitudes HTTP.
final dioProvider = Provider((ref) => DioClient());

/// Proveedor del datasource remoto para películas.
final movieRemoteDataSourceProvider = Provider(
  (ref) => MovieRemoteDataSourceImpl(dioClient: ref.watch(dioProvider)),
);

/// Proveedor del repositorio de películas que interactúa con el datasource remoto.
final movieRepositoryProvider = Provider(
  (ref) => MovieRepositoryImpl(
      remoteDataSource: ref.watch(movieRemoteDataSourceProvider)),
);

/// Proveedor del caso de uso para obtener películas.
final getMoviesProvider = Provider(
  (ref) => GetMovies(repository: ref.watch(movieRepositoryProvider)),
);

/// Proveedor futuro que obtiene y gestiona la lista de películas.
final moviesProvider = FutureProvider<List>((ref) async {
  return await ref
      .watch(getMoviesProvider)
      .call(); // Llama al caso de uso para obtener películas
});
