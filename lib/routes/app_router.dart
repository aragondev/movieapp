import 'package:go_router/go_router.dart';
import 'package:your_project_name/features/movie/presentation/pages/movie_list_page.dart';
import 'package:your_project_name/features/movie/presentation/pages/movie_detail_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MovieListPage(),
    ),
    GoRoute(
      path: '/movie/:id',
      builder: (context, state) {
        final id = state.params['id']!;
        return MovieDetailPage(movieId: id);
      },
    ),
  ],
);
