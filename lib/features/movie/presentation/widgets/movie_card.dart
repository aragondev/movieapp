import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/routes/app_router.dart';

/// Widget para mostrar la información básica de una película en forma de tarjeta.
class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          context.go(
              '/movie/${movie.id}'); // Navega a la pantalla de detalles de la película
        },
        leading:
            Image.network(movie.poster), // Muestra la imagen de la película
        title: Text(movie.title), // Muestra el título de la película
        subtitle: Text('${movie.year}'), // Muestra el año de la película
      ),
    );
  }
}
