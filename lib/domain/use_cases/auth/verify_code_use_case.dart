import 'package:we/core/error/result.dart';
import 'package:we/data/models/auth/license/verify_code_request.dart';
import 'package:we/domain/repositories/auth/license_repository.dart';

class VerifyCodeUseCase {
  final LicenseRepository _repository;
  VerifyCodeUseCase(this._repository);

  Future<Result<void>> call(VerifyCodeRequest request) async {
    return await _repository.verifyCode(request);
  }
}