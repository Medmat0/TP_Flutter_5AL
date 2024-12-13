class AppException implements Exception {
  final String message;
  final int? code;

  AppException({required this.message, this.code});

  factory AppException.from(Object error) {
    if (error is AppException) {
      return error;
    } else {
      return AppException(message: error.toString());
    }
  }
}
