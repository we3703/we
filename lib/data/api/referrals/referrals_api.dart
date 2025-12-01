import 'dart:convert';
import 'package:we/core/config/http_client.dart';

class ReferralsApi {
  final HttpClient client;
  ReferralsApi(this.client);

  Future<Map<String, dynamic>> getReferralTree() async {
    final res = await client.get('/referrals/me/tree');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> getReferralSummary() async {
    final res = await client.get('/referrals/me');
    return jsonDecode(res.body);
  }
}
