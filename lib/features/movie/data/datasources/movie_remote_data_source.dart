import 'package:dio/dio.dart';
import 'package:movie_app/core/constants/error_messages.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';

/// Interfaz que define los métodos para interactuar con la fuente de datos remota de películas.
abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getAllMovies(); // Obtiene todas las películas
  Future<MovieModel> getMovieById(int id); // Obtiene una película por ID
  Future<List<MovieModel>> searchMovies(
      String query); // Busca películas por título
}

/// Implementación concreta de MovieRemoteDataSource utilizando Dio para hacer solicitudes HTTP.
class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final DioClient dioClient;

  /// Constructor que requiere una instancia de DioClient.
  MovieRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<MovieModel>> getAllMovies() async {
    try {
      final response =
          await dioClient.get('movies'); // Solicita todas las películas
      // Mapea la respuesta JSON a una lista de objetos MovieModel
      return (response.data as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } on DioException catch (e) {
      // Maneja y lanza un error basado en el tipo de error de Dio
      throw _handleDioError(e);
    }
  }

  @override
  Future<MovieModel> getMovieById(int id) async {
    try {
      final response =
          await dioClient.get('movies/$id'); // Solicita una película por ID
      return MovieModel.fromJson(
          response.data); // Convierte la respuesta JSON a un objeto MovieModel
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await dioClient
          .get('movies', queryParameters: {'search': query}); // Busca películas
      return (response.data as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Método privado para manejar errores de Dio y devolver mensajes de error específicos.
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ErrorMessages.timeoutError; // Error de tiempo de espera
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 404) {
          return ErrorMessages.notFound; // Error 404: no encontrado
        } else if (e.response?.statusCode == 500) {
          return ErrorMessages.serverError; // Error 500: servidor
        } else {
          return ErrorMessages.unexpectedError; // Error inesperado
        }
      case DioExceptionType.cancel:
        return ErrorMessages.unexpectedError; // Error por cancelación
      case DioExceptionType.unknown:
        return ErrorMessages.networkError; // Error de red
      default:
        return ErrorMessages.unexpectedError; // Error por defecto
    }
  }
}
