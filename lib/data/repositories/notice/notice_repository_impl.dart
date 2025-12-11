import 'dart:io';

import 'package:we/core/error/failure.dart';
import 'package:we/core/error/http_exception.dart';
import 'package:we/core/error/error_extractor.dart'; // Import the new error extractor
import 'package:we/core/error/result.dart';
import 'package:we/data/api/notice/notice_api.dart';
import 'package:we/data/models/notice/notice.dart';
import 'package:we/domain/repositories/notice/notice_repository.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeApi noticeApi;

  NoticeRepositoryImpl(this.noticeApi);

  @override
  Future<Result<List<Notice>>> getNotices() async {
    try {
      final response = await noticeApi.getNotices();
      final data = response['data'];

      // Handle both array and object response formats
      final List<dynamic> noticeListData;
      if (data is List) {
        // data is directly an array: {"data": [...]}
        noticeListData = data;
      } else if (data is Map<String, dynamic>) {
        // data is an object with notices field: {"data": {"notices": [...]}}
        noticeListData = data['notices'] as List? ?? [];
      } else {
        noticeListData = [];
      }

      final noticeList = noticeListData
          .map((notice) => Notice.fromJson(notice as Map<String, dynamic>))
          .toList();
      return Result.success(noticeList);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('공지사항을 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<Notice>> getNoticeDetail(String noticeId) async {
    try {
      final response = await noticeApi.getNoticeDetail(noticeId);
      final notice = Notice.fromJson(response);
      return Result.success(notice);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 404) {
        return Result.failure(ServerFailure(errorMessage, 404));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('공지사항을 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
