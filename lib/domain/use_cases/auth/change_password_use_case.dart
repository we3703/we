import 'package:we/core/error/result.dart';
import 'package:we/data/models/auth/change_password_request.dart';
import 'package:we/domain/repositories/auth/auth_repository.dart';

class ChangePasswordUseCase {
  final AuthRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<Result<void>> call(ChangePasswordRequest request) {
    return _repository.changePassword(request);
  }
}
