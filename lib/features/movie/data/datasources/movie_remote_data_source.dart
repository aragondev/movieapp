import 'package:dio/dio.dart';
import 'package:movie_app/core/constants/error_messages.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getAllMovies();
  Future<MovieModel> getMovieById(int id);
  Future<List<MovieModel>> getMoviesWithLimit(int limit);
  Future<List<MovieModel>> searchMovies(String query);
  Future<List<MovieModel>> sortMoviesByName({String order = 'asc'});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final DioClient dioClient;

  MovieRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<MovieModel>> getAllMovies() async {
    try {
      final response = await dioClient.get('movies');
      return _parseMovieList(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception(ErrorMessages.unexpectedError);
    }
  }

  @override
  Future<MovieModel> getMovieById(int id) async {
    try {
      final response = await dioClient.get('movies/$id');
      return MovieModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception(ErrorMessages.unexpectedError);
    }
  }

  @override
  Future<List<MovieModel>> getMoviesWithLimit(int limit) async {
    try {
      final response =
          await dioClient.get('movies', queryParameters: {'limit': limit});
      return _parseMovieList(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception(ErrorMessages.unexpectedError);
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response =
          await dioClient.get('movies', queryParameters: {'search': query});
      return _parseMovieList(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception(ErrorMessages.unexpectedError);
    }
  }

  @override
  Future<List<MovieModel>> sortMoviesByName({String order = 'asc'}) async {
    try {
      final response = await dioClient
          .get('movies', queryParameters: {'sort': 'name', 'order': order});
      return _parseMovieList(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception(ErrorMessages.unexpectedError);
    }
  }

  List<MovieModel> _parseMovieList(Response response) {
    return (response.data as List)
        .map((movie) => MovieModel.fromJson(movie))
        .toList();
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(ErrorMessages.timeoutError);
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 404) {
          return Exception(ErrorMessages.notFound);
        } else if (e.response?.statusCode == 500) {
          return Exception(ErrorMessages.serverError);
        } else {
          return Exception(ErrorMessages.unexpectedError);
        }
      case DioExceptionType.cancel:
        return Exception(ErrorMessages.unexpectedError);
      case DioExceptionType.unknown:
        return Exception(ErrorMessages.networkError);
      default:
        return Exception(ErrorMessages.unexpectedError);
    }
  }
}
