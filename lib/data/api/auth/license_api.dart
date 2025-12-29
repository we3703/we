import 'dart:convert';
import 'package:we/core/api/http_client.dart';

class LicenseApi {
  final HttpClient client;

  LicenseApi(this.client);

  Future<Map<String, dynamic>> sendCode(Map<String, dynamic> body) async {
    final res = await client.post('/license/code', body: body);
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> verifyCode(Map<String, dynamic> body) async {
    final res = await client.post('/license/verify', body: body);
    return jsonDecode(res.body);
  }
}
