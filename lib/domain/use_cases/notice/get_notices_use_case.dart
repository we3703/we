import 'package:we/core/error/result.dart';
import 'package:we/domain/entities/notice/notice_entity.dart';
import 'package:we/domain/repositories/notice/notice_repository.dart';

class GetNoticesUseCase {
  final NoticeRepository _repository;

  GetNoticesUseCase(this._repository);

  Future<Result<List<NoticeEntity>>> call() async {
    final result = await _repository.getNotices();
    return result.when(
      success: (notices) {
        final noticeEntities = notices
            .map(
              (notice) => NoticeEntity(
                id: notice.id,
                title: notice.title,
                content: notice.content,
                createdAt: notice.createdAt,
                updatedAt: notice.updatedAt,
              ),
            )
            .toList();
        return Result.success(noticeEntities);
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
