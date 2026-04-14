import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'failures/api_failure.dart';

/// Cliente GET con `Accept: application/json`, timeout y mapeo a [ApiFailure].
class HttpBodyClient {
  HttpBodyClient({http.Client? httpClient})
    : _client = httpClient ?? http.Client();

  final http.Client _client;

  /// GET a [uri]; éxito devuelve el cuerpo como texto; errores como [NetworkFailure] o [HttpFailure].
  Future<Either<ApiFailure, String>> getJsonBody(Uri uri) async {
    try {
      final response = await _client
          .get(uri, headers: const {'Accept': 'application/json'})
          .timeout(FakeStoreEndpoints.requestTimeout);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(response.body);
      }
      return Left(
        HttpFailure(
          response.statusCode,
          'Respuesta HTTP ${response.statusCode} para $uri',
        ),
      );
    } on Exception catch (e) {
      return Left(NetworkFailure('Error de red al consultar $uri: $e'));
    }
  }
}
