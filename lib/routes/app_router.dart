import 'package:go_router/go_router.dart';
import 'package:movie_app/features/movie/presentation/pages/movie_detail_page.dart';
import 'package:movie_app/features/movie/presentation/pages/movie_list_page.dart';

/// Configuración de rutas para la aplicación usando GoRouter.
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/', // Ruta para la pantalla principal
      builder: (context, state) => MovieListPage(),
    ),
    GoRoute(
      path:
          '/movie/:id', // Ruta para la pantalla de detalles de una película específica
      builder: (context, state) {
        final id = state.pathParameters[
            'id']!; // Usa state.pathParameters en lugar de state.params
        return MovieDetailPage(
            movieId: int.parse(
                id)); // Pasa el ID de la película a la pantalla de detalles
      },
    ),
  ],
);
