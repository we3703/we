import 'dart:convert';
import 'package:we/core/config/http_client.dart';

class NoticeApi {
  final HttpClient client;
  NoticeApi(this.client);

  Future<Map<String, dynamic>> getNotices() async {
    final res = await client.get('/notices');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> getNoticeDetail(String noticeId) async {
    final res = await client.get('/notices/$noticeId');
    return jsonDecode(res.body);
  }
}
