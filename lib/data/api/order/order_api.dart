import 'dart:convert';
import 'package:we/core/api/http_client.dart';

class OrderApi {
  final HttpClient client;
  OrderApi(this.client);

  Future<Map<String, dynamic>> getMyOrders({
    int page = 1,
    int limit = 10,
  }) async {
    final res = await client.get('/orders/me?page=$page&limit=$limit');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> getOrderDetail(String orderId) async {
    final res = await client.get('/orders/$orderId');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> createOrder(
    Map<String, dynamic> orderData,
  ) async {
    final res = await client.post('/orders', body: orderData);
    return jsonDecode(res.body);
  }
}
