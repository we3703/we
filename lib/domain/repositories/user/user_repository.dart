import 'package:we/core/api/error/result.dart';
import 'package:we/data/models/user/my_info.dart';
import 'package:we/data/models/user/update_my_info_request.dart';
import 'package:we/data/models/user/update_my_info_response.dart';

/// User Repository Interface
///
/// Token은 HttpClient의 Interceptor에서 자동으로 추가되므로
/// 메서드 파라미터로 전달할 필요가 없습니다.
abstract class UserRepository {
  /// Get current user information
  Future<Result<MyInfo>> getMe();

  /// Update current user information
  Future<Result<UpdateMyInfoResponse>> updateMe(UpdateMyInfoRequest info);
}
