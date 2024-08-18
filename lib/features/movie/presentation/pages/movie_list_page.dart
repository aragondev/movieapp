import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/constants/error_messages.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_card.dart';

class MovieListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtiene el estado de las películas usando el proveedor moviesProvider.
    final moviesAsyncValue = ref.watch(moviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: moviesAsyncValue.when(
        data: (movies) => ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieCard(movie: movie);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          // Imprimir el error en la consola para más detalles
          print('Error: $error');
          return Center(child: Text(ErrorMessages.unexpectedError));
        },
      ),
    );
  }
}
