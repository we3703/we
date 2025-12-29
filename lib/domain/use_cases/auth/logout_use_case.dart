import 'package:we/core/api/error/result.dart';
import 'package:we/domain/repositories/auth/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Result<void>> call() {
    return _repository.logout();
  }
}
