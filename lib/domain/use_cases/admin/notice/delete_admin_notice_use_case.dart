import 'package:we/domain/repositories/admin/admin_notice_repository.dart';
import 'package:we/core/api/error/result.dart';
import 'package:we/domain/entities/common/delete_response_entity.dart';

class DeleteAdminNoticeUseCase {
  final AdminNoticeRepository _repository;

  DeleteAdminNoticeUseCase(this._repository);

  Future<Result<DeleteResponseEntity>> call(String noticeId) async {
    final result = await _repository.deleteAdminNotice(noticeId);
    return result.when(
      success: (response) {
        return Result.success(
          DeleteResponseEntity(id: response.id, deletedAt: response.deletedAt),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
