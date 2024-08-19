import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getMovies();
  Future<MovieModel> getMovieById(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final DioClient dioClient;

  MovieRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await dioClient.get('movies');
    return (response.data as List)
        .map((movie) => MovieModel.fromJson(movie))
        .toList();
  }

  @override
  Future<MovieModel> getMovieById(int id) async {
    final response = await dioClient.get('movies/$id');
    return MovieModel.fromJson(response.data);
  }
}
