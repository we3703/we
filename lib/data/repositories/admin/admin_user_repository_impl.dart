import 'dart:io';

import 'package:we/core/error/failure.dart';
import 'package:we/core/error/http_exception.dart';
import 'package:we/core/error/result.dart';
import 'package:we/core/error/error_extractor.dart'; // Import the new error extractor
import 'package:we/domain/repositories/admin/admin_user_repository.dart';
import 'package:we/data/api/admin/admin_user_api.dart';
import 'package:we/data/models/admin/user/paginated_admin_users.dart';

class AdminUserRepositoryImpl implements AdminUserRepository {
  final AdminUserApi adminUserApi;

  AdminUserRepositoryImpl(this.adminUserApi);

  @override
  Future<Result<PaginatedAdminUsers>> getAdminUsers() async {
    try {
      final response = await adminUserApi.getAdminUsers();
      final users = PaginatedAdminUsersExtension.fromJson(response);
      return Result.success(users);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      if (e.statusCode == 403) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('사용자 목록을 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
