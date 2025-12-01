import 'dart:convert';
import 'package:we/core/config/http_client.dart';

class PointsApi {
  final HttpClient client;
  PointsApi(this.client);

  Future<Map<String, dynamic>> rechargePoints(Map<String, dynamic> body) async {
    final res = await client.post('/points/recharge', body: body);
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> rechargePointsSuccess() async {
    final res = await client.get('/points/recharge/success');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> rechargePointsFail() async {
    final res = await client.get('/points/recharge/fail');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> getRechargeHistory() async {
    final res = await client.get('/points/recharge/history');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> getPointsHistory() async {
    final res = await client.get('/points/history');
    return jsonDecode(res.body);
  }
}
