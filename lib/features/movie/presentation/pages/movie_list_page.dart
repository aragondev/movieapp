import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/constants/error_messages.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_card.dart';

/// Pantalla principal que muestra la lista de películas.
/// Consume el estado de las películas usando Riverpod y maneja los diferentes estados (cargando, error, datos).
class MovieListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtiene el estado de las películas usando el proveedor moviesProvider.
    final moviesAsyncValue = ref.watch(moviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'), // Título de la app bar
      ),
      body: moviesAsyncValue.when(
        // Si los datos se cargan correctamente, muestra una lista de películas.
        data: (movies) => ListView.builder(
          itemCount: movies.length, // Número de películas
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieCard(
                movie: movie); // Muestra una tarjeta para cada película
          },
        ),
        loading: () => const Center(
            child:
                CircularProgressIndicator()), // Muestra un indicador de carga
        error: (error, stackTrace) {
          String errorMessage = error.toString();
          // Muestra un mensaje de error dependiendo del tipo de error
          if (errorMessage == ErrorMessages.networkError ||
              errorMessage == ErrorMessages.serverError ||
              errorMessage == ErrorMessages.notFound ||
              errorMessage == ErrorMessages.timeoutError ||
              errorMessage == ErrorMessages.unexpectedError) {
            return Center(child: Text(errorMessage));
          } else {
            return const Center(child: Text(ErrorMessages.unexpectedError));
          }
        },
      ),
    );
  }
}
