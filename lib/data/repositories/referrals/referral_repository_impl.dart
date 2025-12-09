import 'dart:io';

import 'package:we/core/error/failure.dart';
import 'package:we/core/error/http_exception.dart';
import 'package:we/core/error/result.dart';
import 'package:we/core/error/error_extractor.dart'; // Import the new error extractor
import 'package:we/domain/repositories/referrals/referral_repository.dart';
import 'package:we/data/api/referrals/referrals_api.dart';
import 'package:we/data/models/referral/referral_node.dart';
import 'package:we/data/models/referral/referral_summary.dart';

class ReferralRepositoryImpl implements ReferralRepository {
  final ReferralsApi referralsApi;

  ReferralRepositoryImpl(this.referralsApi);

  @override
  Future<Result<ReferralNode>> getReferralTree() async {
    try {
      final response = await referralsApi.getReferralTree();
      final tree = ReferralNode.fromJson(response);
      return Result.success(tree);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('추천인 트리를 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<ReferralSummary>> getReferralSummary() async {
    try {
      final response = await referralsApi.getReferralSummary();
      final summary = ReferralSummary.fromJson(response);
      return Result.success(summary);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('추천인 요약 정보를 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
