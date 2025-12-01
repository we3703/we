import 'package:we/core/error/result.dart';
import 'package:we/domain/entities/notice/notice_entity.dart';
import 'package:we/domain/repositories/notice/notice_repository.dart';

class GetNoticeDetailUseCase {
  final NoticeRepository _repository;

  GetNoticeDetailUseCase(this._repository);

  Future<Result<NoticeEntity>> call(String noticeId) async {
    final result = await _repository.getNoticeDetail(noticeId);
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
