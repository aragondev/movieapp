import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';

class MovieDetailPage extends ConsumerWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

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
                  const SizedBox(height: 16.0),
                  const Text(
                    'Actors:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  // Mostrar la lista de nombres de actores
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: movie.actors.length,
                      itemBuilder: (context, index) {
                        final actorName = movie.actors[index]
                            as String; // Asegurarse de que es una cadena
                        return const Text(
                            "Actor"); // Pasar la cadena a ActorCard
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
              child: Text(
                  'Movie not found')); // Muestra un mensaje si no se encuentra la película
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pop(), // Regresa a la lista de películas
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
