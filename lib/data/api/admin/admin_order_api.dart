import 'dart:convert';
import 'package:we/core/api/http_client.dart';

class AdminOrderApi {
  final HttpClient client;
  AdminOrderApi(this.client);

  Future<Map<String, dynamic>> getAdminOrders() async {
    final res = await client.get('/admin/orders');
    return jsonDecode(res.body);
  }
}
