import 'dart:convert';
import 'package:we/core/config/http_client.dart';

class AdminUserApi {
  final HttpClient client;
  AdminUserApi(this.client);

  Future<Map<String, dynamic>> getAdminUsers() async {
    final res = await client.get('/admin/users');
    return jsonDecode(res.body);
  }
}
