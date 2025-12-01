import 'dart:convert';
import 'package:we/core/config/http_client.dart';

class ProductApi {
  final HttpClient client;
  ProductApi(this.client);

  Future<Map<String, dynamic>> getProducts() async {
    final res = await client.get('/products');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> createProduct(Map<String, dynamic> body) async {
    final res = await client.post('/products', body: body);
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> getProductDetail(String productId) async {
    final res = await client.get('/products/$productId');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> updateProduct(
    String productId,
    Map<String, dynamic> body,
  ) async {
    final res = await client.patch('/products/$productId', body: body);
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> deleteProduct(String productId) async {
    final res = await client.delete('/products/$productId');
    return jsonDecode(res.body);
  }
}
