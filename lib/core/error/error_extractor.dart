import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:we/core/error/http_exception.dart';

String extractErrorMessage(CustomHttpException e) {
  try {
    debugPrint('extractErrorMessage - body type: ${e.body.runtimeType}');
    debugPrint('extractErrorMessage - body: ${e.body}');

    // Ensure body is a string
    final bodyString = e.body.toString();
    if (bodyString.isEmpty) {
      return '오류가 발생했습니다.';
    }

    final errorBody = jsonDecode(bodyString);

    final message =
        errorBody['message'] ??
        errorBody['detail'] ??
        errorBody['error'] ??
        '오류가 발생했습니다.';

    return message.toString();
  } catch (parseError) {
    debugPrint('extractErrorMessage parse error: $parseError');
    // JSON이 아니면 그대로 본문(body) 혹은 statusCode 기반 출력
    final bodyString = e.body.toString();
    return bodyString.isNotEmpty ? bodyString : '오류가 발생했습니다.';
  }
}
