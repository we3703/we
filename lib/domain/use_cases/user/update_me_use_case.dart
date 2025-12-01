import 'package:we/data/models/user/update_my_info_request.dart';

import 'package:we/core/error/result.dart';
import 'package:we/domain/entities/user/update_my_info_entity.dart';
import 'package:we/domain/repositories/user/user_repository.dart';

class UpdateMeUseCase {
  final UserRepository _repository;

  UpdateMeUseCase(this._repository);

  Future<Result<UpdateMyInfoEntity>> call(UpdateMyInfoRequest request) async {
    final result = await _repository.updateMe(request);
    return result.when(
      success: (response) {
        return Result.success(
          UpdateMyInfoEntity(
            userId: response.userId,
            name: response.name,
            phone: response.phone,
            updatedAt: response.updatedAt,
          ),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
