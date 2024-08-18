import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';

/// Pantalla que muestra los detalles de una película seleccionada.
class MovieDetailPage extends ConsumerWidget {
  final int movieId;

  MovieDetailPage({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Proveedor que obtiene los detalles de la película usando el ID
    final movieProvider =
        ref.watch(movieRepositoryProvider).getMovieById(movieId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'), // Título de la app bar
      ),
      body: FutureBuilder<Movie>(
        future: movieProvider,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Muestra un indicador de carga
          } else if (snapshot.hasError) {
            return const Center(
                child: Text(
                    'Failed to load movie details')); // Muestra un mensaje de error
          } else if (snapshot.hasData) {
            final movie = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                      movie.poster), // Muestra la imagen de la película
                  const SizedBox(height: 16.0),
                  Text(
                    movie.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ), // Muestra el título de la película
                  const SizedBox(height: 8.0),
                  Text('Year: ${movie.year}'), // Muestra el año de la película
                  const SizedBox(height: 8.0),
                  Text(
                      'Director: ${movie.director}'), // Muestra el director de la película
                  const SizedBox(height: 8.0),
                  Text(
                      'Plot: ${movie.plot}'), // Muestra la trama de la película
                ],
              ),
            );
          }
          return const Center(
              child: Text(
                  'Movie not found')); // Muestra un mensaje si no se encuentra la película
        },
      ),
    );
  }
}
