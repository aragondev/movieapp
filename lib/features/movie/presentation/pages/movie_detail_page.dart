import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/features/actor/presentation/provider/actor_provider.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';

class MovieDetailPage extends ConsumerWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsyncValue = ref.watch(movieProvider(movieId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
        backgroundColor: const Color.fromARGB(
            255, 208, 63, 177), // Fondo pastel suave para la AppBar
      ),
      body: movieAsyncValue.when(
        data: (movie) => SingleChildScrollView(
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
                    width: double.infinity, // Ocupa todo el ancho disponible
                    height: 300.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  movie.title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[800], // Color pastel para el título
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
                        color: Colors
                            .purple[600], // Color pastel suave para el texto
                      ),
                    ),
                    Text(
                      'Rating: ${movie.rating}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors
                            .purple[600], // Color pastel suave para el texto
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  movie.plot,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors
                        .purple[300], // Color pastel más claro para el texto
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
                  height: 150.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movie.actors.length,
                    itemBuilder: (context, index) {
                      final actorName = movie.actors[index];
                      final actorAsyncValue =
                          ref.watch(actorProvider(actorName));

                      return actorAsyncValue.when(
                        data: (actor) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(actor.image),
                                  radius: 50,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  actor.name,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ],
                            ),
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stackTrace) =>
                            const Text('Error loading actor'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const Center(child: Text('Failed to load movie details')),
      ),
    );
  }
}
