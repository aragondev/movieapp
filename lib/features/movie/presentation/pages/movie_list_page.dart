import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/error_messages.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_card.dart';

class MovieListPage extends ConsumerStatefulWidget {
  const MovieListPage({super.key});

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends ConsumerState<MovieListPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final moviesAsyncValue = ref.watch(moviesProvider);
    final bool isGrid = ref.watch(viewModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              ref.read(viewModeProvider.notifier).state = !isGrid;
            },
          ),
        ],
      ),
      body: moviesAsyncValue.when(
        data: (movies) => isGrid
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCardGrid(movie: movie);
                },
              )
            : ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCardClassic(movie: movie);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return const Center(child: Text(ErrorMessages.unexpectedError));
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.deepPurple,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              if (index == 1) {
                _showSearchBottomSheet(context);
              } else if (index == 0) {
                context.go('/');
              }
            },
          ),
        ),
      ),
    );
  }

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _SearchBottomSheetContent(),
              ),
            );
          },
        );
      },
    );
  }
}

class _SearchBottomSheetContent extends StatefulWidget {
  @override
  __SearchBottomSheetContentState createState() =>
      __SearchBottomSheetContentState();
}

class __SearchBottomSheetContentState extends State<_SearchBottomSheetContent> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Search Movies',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Enter movie name...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          onChanged: (query) {
            setState(() {
              _searchQuery = query;
            });
          },
        ),
        const SizedBox(height: 16.0),
        Consumer(
          builder: (context, ref, child) {
            final moviesAsyncValue = ref.watch(moviesProvider);

            return moviesAsyncValue.when(
              data: (movies) {
                final filteredMovies = movies.where((movie) {
                  return movie.title
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase());
                }).toList();

                return filteredMovies.isEmpty
                    ? const Text('No movies found.')
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredMovies.length,
                        itemBuilder: (context, index) {
                          final movie = filteredMovies[index];
                          return ListTile(
                            title: Text(movie.title),
                            subtitle: Text('Year: ${movie.year}'),
                            onTap: () {
                              Navigator.pop(context);
                              context.go('/movie/${movie.id}');
                            },
                          );
                        },
                      );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) {
                return const Text(ErrorMessages.unexpectedError);
              },
            );
          },
        ),
      ],
    );
  }
}
