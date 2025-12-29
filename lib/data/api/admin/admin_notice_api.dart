import 'dart:convert';
import 'package:we/core/api/http_client.dart';

class AdminNoticeApi {
  final HttpClient client;
  AdminNoticeApi(this.client);

  Future<Map<String, dynamic>> createAdminNotice(
    Map<String, dynamic> body,
  ) async {
    final res = await client.post('/admin/notices', body: body);
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> updateAdminNotice(
    String noticeId,
    Map<String, dynamic> body,
  ) async {
    final res = await client.patch('/admin/notices/$noticeId', body: body);
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> deleteAdminNotice(String noticeId) async {
    final res = await client.delete('/admin/notices/$noticeId');
    return jsonDecode(res.body);
  }
}
