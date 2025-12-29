import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:we/core/api/http_client.dart';

class AuthApi {
  final HttpClient client;
  AuthApi(this.client);

  Future<Map<String, dynamic>> signup(Map<String, dynamic> body) async {
    final res = await client.post('/auth/signup', body: body);
    debugPrint('Signup API response body type: ${res.body.runtimeType}');
    debugPrint('Signup API response body: ${res.body}');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final res = await client.post('/auth/login', body: body);
    debugPrint('Login API response body type: ${res.body.runtimeType}');
    debugPrint('Login API response body: ${res.body}');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> refresh(Map<String, dynamic> body) async {
    final res = await client.post('/auth/refresh', body: body);
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> body) async {
    final res = await client.post('/auth/change-password', body: body);
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> sendCode(Map<String, dynamic> body) async {
    final res = await client.post('/auth/send-code', body: body);
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> verifyCode(Map<String, dynamic> body) async {
    final res = await client.post('/auth/verify-code', body: body);
    return jsonDecode(res.body);
  }
}
