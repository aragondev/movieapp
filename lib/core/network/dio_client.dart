import 'package:dio/dio.dart';

/// DioClient es una clase que configura y proporciona una instancia de Dio
/// con opciones predeterminadas para realizar solicitudes HTTP.
class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(BaseOptions(
          baseUrl:
              'https://freetestapi.com/api/v1/', // Configura la URL base para todas las solicitudes
          connectTimeout: const Duration(
              seconds: 5), // Tiempo máximo para establecer conexión
          receiveTimeout:
              const Duration(seconds: 3), // Tiempo máximo para recibir datos
        ));

  /// Realiza una solicitud GET a la URL especificada.
  /// [queryParameters] son los parámetros opcionales que se pueden agregar a la URL.
  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response; // Devuelve la respuesta HTTP obtenida
    } on DioException catch (e) {
      // Manejo de errores de solicitud HTTP con DioError
      throw Exception('Error fetching data: ${e.message}');
    }
  }
}
