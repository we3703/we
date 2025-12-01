import 'dart:io';

import 'package:we/core/error/failure.dart';
import 'package:we/core/error/http_exception.dart';
import 'package:we/core/error/result.dart';
import 'package:we/core/error/error_extractor.dart'; // Import the new error extractor
import 'package:we/domain/repositories/user/user_repository.dart';
import 'package:we/data/api/user/user_api.dart';
import 'package:we/data/models/user/my_info.dart';
import 'package:we/data/models/user/update_my_info_request.dart';
import 'package:we/data/models/user/update_my_info_response.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApi userApi;

  UserRepositoryImpl(this.userApi);

  @override
  Future<Result<MyInfo>> getMe() async {
    try {
      final response = await userApi.getMe();
      final myInfo = MyInfo.fromJson(response);
      return Result.success(myInfo);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(
        ServerFailure(errorMessage, e.statusCode),
      );
    } catch (e) {
      return Result.failure(
        ServerFailure('사용자 정보를 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<UpdateMyInfoResponse>> updateMe(
    UpdateMyInfoRequest info,
  ) async {
    try {
      final response = await userApi.updateMe(info);
      final updateResponse = UpdateMyInfoResponse.fromJson(response);
      return Result.success(updateResponse);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(
        ServerFailure(errorMessage, e.statusCode),
      );
    } catch (e) {
      return Result.failure(
        ServerFailure('사용자 정보 수정 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
