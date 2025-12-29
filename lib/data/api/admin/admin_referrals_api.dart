import 'dart:convert';
import 'package:we/core/api/http_client.dart';

class AdminReferralsApi {
  final HttpClient client;
  AdminReferralsApi(this.client);

  Future<Map<String, dynamic>> getAdminUserReferralTree(String userId) async {
    final res = await client.get('/admin/referrals/$userId/tree');
    return jsonDecode(res.body);
  }
}
