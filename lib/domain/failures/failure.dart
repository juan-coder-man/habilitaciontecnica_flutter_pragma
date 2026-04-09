sealed class Failure {
  const Failure(this.message);

  final String message;
}

final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

final class HttpFailure extends Failure {
  const HttpFailure(this.statusCode, String message) : super(message);

  final int statusCode;
}

final class ParseFailure extends Failure {
  const ParseFailure(super.message);
}
