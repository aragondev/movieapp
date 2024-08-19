import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';

class MovieDetailPage extends ConsumerWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieProvider =
        ref.watch(movieRepositoryProvider).getMovieById(movieId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Volver a la página anterior
            context.go('/');
          },
        ),
        backgroundColor:
            Colors.purple[100], // Fondo pastel suave para la AppBar
      ),
      body: FutureBuilder<Movie>(
        future: movieProvider,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load movie details'));
          } else if (snapshot.hasData) {
            final movie = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        movie.poster,
                        fit: BoxFit.cover,
                        width:
                            double.infinity, // Ocupa todo el ancho disponible
                        height: 300.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color:
                            Colors.purple[800], // Color pastel para el título
                        fontFamily: 'Cinzel',
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Year: ${movie.year}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple[
                                600], // Color pastel suave para el texto
                          ),
                        ),
                        Text(
                          'Rating: ${movie.rating}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple[
                                600], // Color pastel suave para el texto
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      movie.plot,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.purple[
                            300], // Color pastel más claro para el texto
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Actors',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .purple, // Color pastel para el título de los actores
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 100.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movie.actors.length,
                        itemBuilder: (context, index) {
                          final actor = movie.actors[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Chip(
                              label: Text(
                                actor,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors
                                  .purple[100], // Color pastel para los chips
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Movie not found'));
        },
      ),
    );
  }
}
