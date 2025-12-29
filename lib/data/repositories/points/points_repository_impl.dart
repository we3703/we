import 'dart:io';

import 'package:we/core/api/error/failure.dart';
import 'package:we/core/api/error/http_exception.dart';
import 'package:we/core/api/error/result.dart';
import 'package:we/core/api/error/error_extractor.dart';
import 'package:we/domain/repositories/points/points_repository.dart';
import 'package:we/data/api/points/points_api.dart';
import 'package:we/data/models/common/api_response.dart';
import 'package:we/data/models/point/paginated_recharge_history.dart';
import 'package:we/data/models/point/points_history.dart';
import 'package:we/data/models/point/recharge_points_request.dart';

class PointsRepositoryImpl implements PointsRepository {
  final PointsApi pointsApi;

  PointsRepositoryImpl(this.pointsApi);

  @override
  Future<Result<void>> rechargePoints(RechargePointsRequest request) async {
    try {
      await pointsApi.rechargePoints(request.toJson());
      // ignore: void_checks
      return Result.success(unit);
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
        ServerFailure('포인트 충전 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<void>> rechargePointsSuccess() async {
    try {
      await pointsApi.rechargePointsSuccess();
      // ignore: void_checks
      return Result.success(unit);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('포인트 충전 확인 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<void>> rechargePointsFail() async {
    try {
      await pointsApi.rechargePointsFail();
      // ignore: void_checks
      return Result.success(unit);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('포인트 충전 실패 처리 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<PaginatedRechargeHistory>> getRechargeHistory() async {
    try {
      final response = await pointsApi.getRechargeHistory();
      final history = ApiResponse.fromJson(
        response,
        (data) => PaginatedRechargeHistoryExtension.fromJson(data),
      ).data;
      return Result.success(history);
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
        ServerFailure('충전 내역을 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<PointsHistory>> getPointsHistory() async {
    try {
      final response = await pointsApi.getPointsHistory();
      final data = response['data'] as Map<String, dynamic>? ?? response;
      final history = PointsHistory.fromJson(data);
      return Result.success(history);
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
        ServerFailure('포인트 내역을 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
