import 'dart:convert';
import 'package:we/data/models/user/update_my_info_request.dart';
import 'package:we/core/config/http_client.dart';

/// User API
///
/// HttpClient가 자동으로 Authorization 헤더를 추가하므로
/// token 파라미터는 더 이상 필요하지 않습니다.
class UserApi {
  final HttpClient client;
  UserApi(this.client);

  Future<Map<String, dynamic>> getMe() async {
    final res = await client.get('/users/me');
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> updateMe(UpdateMyInfoRequest body) async {
    final res = await client.patch('/users/me', body: body.toJson());
    return jsonDecode(res.body);
  }
}
