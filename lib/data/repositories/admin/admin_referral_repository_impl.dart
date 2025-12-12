import 'dart:io';

import 'package:we/core/error/failure.dart';
import 'package:we/core/error/http_exception.dart';
import 'package:we/core/error/result.dart';
import 'package:we/core/error/error_extractor.dart';
import 'package:we/domain/repositories/admin/admin_referral_repository.dart';
import 'package:we/data/api/admin/admin_referrals_api.dart';
import 'package:we/data/models/common/api_response.dart';
import 'package:we/data/models/admin/referral/admin_referral_node.dart';

class AdminReferralRepositoryImpl implements AdminReferralRepository {
  final AdminReferralsApi adminReferralsApi;

  AdminReferralRepositoryImpl(this.adminReferralsApi);

  @override
  Future<Result<AdminReferralNode>> getAdminUserReferralTree(
    String userId,
  ) async {
    try {
      final response = await adminReferralsApi.getAdminUserReferralTree(userId);
      final tree = ApiResponse.fromJson(
        response,
        AdminReferralNode.fromJson,
      ).data;
      return Result.success(tree);
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
      if (e.statusCode == 404) {
        return Result.failure(ServerFailure(errorMessage, 404));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('추천인 트리를 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
