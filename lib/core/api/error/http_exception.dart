import 'dart:io';

class CustomHttpException implements IOException {
  final String message;
  final int statusCode;
  final String body;

  CustomHttpException({
    required this.message,
    required this.statusCode,
    required this.body,
  });

  @override
  String toString() {
    return 'CustomHttpException: $message, statusCode: $statusCode, body: $body';
  }
}
