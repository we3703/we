import 'dart:convert';
import 'package:we/core/error/http_exception.dart';

String extractErrorMessage(CustomHttpException e) {
  try {
    final errorBody = jsonDecode(e.body);

    return errorBody['message']
        ?? errorBody['detail']
        ?? errorBody['error']
        ?? '오류가 발생했습니다.';
  } catch (_) {
    // JSON이 아니면 그대로 본문(body) 혹은 statusCode 기반 출력
    return e.body.isNotEmpty ? e.body : '오류가 발생했습니다.';
  }
}