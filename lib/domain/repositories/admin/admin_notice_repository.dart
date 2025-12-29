import 'package:we/core/api/error/result.dart';
import 'package:we/data/models/admin/notice/delete_notice_response.dart';
import 'package:we/data/models/admin/notice/upsert_notice_request.dart';
import 'package:we/data/models/notice/notice.dart';

/// Admin Notice Repository Interface
abstract class AdminNoticeRepository {
  /// Create a new notice (Admin only)
  Future<Result<Notice>> createAdminNotice(UpsertNoticeRequest request);

  /// Update existing notice (Admin only)
  Future<Result<Notice>> updateAdminNotice(
    String noticeId,
    UpsertNoticeRequest request,
  );

  /// Delete notice (Admin only)
  Future<Result<DeleteNoticeResponse>> deleteAdminNotice(String noticeId);
}
