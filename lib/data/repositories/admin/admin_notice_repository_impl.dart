import 'dart:io';

import 'package:we/core/api/error/failure.dart';
import 'package:we/core/api/error/http_exception.dart';
import 'package:we/core/api/error/result.dart';
import 'package:we/core/api/error/error_extractor.dart';
import 'package:we/domain/repositories/admin/admin_notice_repository.dart';
import 'package:we/data/api/admin/admin_notice_api.dart';
import 'package:we/data/models/common/api_response.dart';
import 'package:we/data/models/admin/notice/delete_notice_response.dart';
import 'package:we/data/models/admin/notice/upsert_notice_request.dart';
import 'package:we/data/models/notice/notice.dart';

class AdminNoticeRepositoryImpl implements AdminNoticeRepository {
  final AdminNoticeApi adminNoticeApi;

  AdminNoticeRepositoryImpl(this.adminNoticeApi);

  @override
  Future<Result<Notice>> createAdminNotice(UpsertNoticeRequest request) async {
    try {
      final response = await adminNoticeApi.createAdminNotice(request.toJson());
      final notice = ApiResponse.fromJson(response, Notice.fromJson).data;
      return Result.success(notice);
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
        ServerFailure('공지사항 생성 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<Notice>> updateAdminNotice(
    String noticeId,
    UpsertNoticeRequest request,
  ) async {
    try {
      final response = await adminNoticeApi.updateAdminNotice(
        noticeId,
        request.toJson(),
      );
      final notice = ApiResponse.fromJson(response, Notice.fromJson).data;
      return Result.success(notice);
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
        ServerFailure('공지사항 수정 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<DeleteNoticeResponse>> deleteAdminNotice(
    String noticeId,
  ) async {
    try {
      final response = await adminNoticeApi.deleteAdminNotice(noticeId);
      final deleteResponse = ApiResponse.fromJson(
        response,
        DeleteNoticeResponse.fromJson,
      ).data;
      return Result.success(deleteResponse);
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
        ServerFailure('공지사항 삭제 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
