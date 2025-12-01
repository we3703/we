import 'package:we/data/models/admin/notice/upsert_notice_request.dart';
import 'package:we/domain/repositories/admin/admin_notice_repository.dart';
import 'package:we/core/error/result.dart';
import 'package:we/domain/entities/notice/notice_entity.dart';

class UpdateAdminNoticeUseCase {
  final AdminNoticeRepository _repository;

  UpdateAdminNoticeUseCase(this._repository);

  Future<Result<NoticeEntity>> call(
    String noticeId,
    UpsertNoticeRequest request,
  ) async {
    final result = await _repository.updateAdminNotice(noticeId, request);
    return result.when(
      success: (notice) {
        return Result.success(
          NoticeEntity(
            id: notice.id,
            title: notice.title,
            content: notice.content,
            createdAt: notice.createdAt,
            updatedAt: notice.updatedAt,
          ),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
