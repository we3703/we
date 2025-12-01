import 'package:we/core/error/result.dart';
import 'package:we/data/models/auth/signup_request.dart';
import 'package:we/domain/repositories/auth/auth_repository.dart';

class SignupUseCase {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  Future<Result<void>> call(SignupRequest request) {
    return _repository.signup(request);
  }
}
