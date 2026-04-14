/// Fallo tipado devuelto por las operaciones del paquete.
///
/// - [message]: Texto legible con el motivo del error.
sealed class ApiFailure {
  const ApiFailure(this.message);

  final String message;
}

/// Error de red, timeout u otra excepción al realizar la petición HTTP.
final class NetworkFailure extends ApiFailure {
  const NetworkFailure(super.message);
}

/// Respuesta HTTP con código fuera del rango 2xx.
///
/// - [statusCode]: Código de estado HTTP recibido.
final class HttpFailure extends ApiFailure {
  const HttpFailure(this.statusCode, String message) : super(message);

  final int statusCode;
}

/// El cuerpo no es JSON válido o no coincide con la forma esperada del parser.
final class ParseFailure extends ApiFailure {
  const ParseFailure(super.message);
}
