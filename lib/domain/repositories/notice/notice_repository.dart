import 'package:we/core/error/result.dart';
import 'package:we/data/models/notice/notice.dart';

/// Notice Repository Interface
abstract class NoticeRepository {
  /// Get list of notices
  Future<Result<List<Notice>>> getNotices();

  /// Get notice detail by ID
  Future<Result<Notice>> getNoticeDetail(String noticeId);
}
