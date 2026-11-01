class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  AppException(this.message, {this.code, this.originalError});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(super.message, {super.code, super.originalError});
}

class DatabaseException extends AppException {
  DatabaseException(super.message, {super.code, super.originalError});
}

class AuthenticationException extends AppException {
  final StackTrace? originalStackTrace;
  final String? stage;

  AuthenticationException(
    super.message, {
    super.code,
    super.originalError,
    this.originalStackTrace,
    this.stage,
  });
}

class ValidationException extends AppException {
  ValidationException(super.message, {super.code, super.originalError});
}
