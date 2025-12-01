import 'dart:convert';
import 'package:we/core/config/http_client.dart';

class CartApi {
  final HttpClient client;
  CartApi(this.client);

  Future<Map<String, dynamic>> addCartItem(Map<String, dynamic> body) async {
    final res = await client.post('/cart/items', body: body);
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> getCart() async {
    final res = await client.get('/cart');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> updateCartItem(
    String itemId,
    Map<String, dynamic> body,
  ) async {
    final res = await client.put('/cart/items/$itemId', body: body);
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> deleteCartItem(String itemId) async {
    final res = await client.delete('/cart/items/$itemId');
    return jsonDecode(res.body);
  }
}
