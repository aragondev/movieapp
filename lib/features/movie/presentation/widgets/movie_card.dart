import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MovieCardClassic extends StatelessWidget {
  final Movie movie;

  const MovieCardClassic({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/movie/${movie.id}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0), // Margen para separar las tarjetas
        decoration: BoxDecoration(
          color: Colors.pink[50], // Fondo pastel suave
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Sombra suave
              offset: const Offset(0, 4),
              blurRadius: 8.0,
            ),
          ],
        ),
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
                  width: double.infinity,
                  height: 200.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple, // Color pastel suave para el texto
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Year: ${movie.year}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors
                          .purple[300], // Color pastel suave para el texto
                    ),
                  ),
                  Text(
                    'Rating: ${movie.rating}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors
                          .purple[300], // Color pastel suave para el texto
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'Director: ${movie.director}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple[300], // Color pastel suave para el texto
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                movie.plot,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors
                      .purple[200], // Color pastel más claro para el texto
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieCardGrid extends StatelessWidget {
  final Movie movie;

  const MovieCardGrid({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/movie/${movie.id}');
      },
      child: Container(
        margin: const EdgeInsets.all(
            8.0), // Margen para separar las tarjetas en el grid
        decoration: BoxDecoration(
          color: Colors.pink[50], // Fondo pastel suave
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Sombra suave
              offset: const Offset(0, 4),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  movie.poster,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple, // Color pastel suave para el texto
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Year: ${movie.year}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors
                          .purple[300], // Color pastel suave para el texto
                    ),
                  ),
                  Text(
                    'Rating: ${movie.rating}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors
                          .purple[300], // Color pastel suave para el texto
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
