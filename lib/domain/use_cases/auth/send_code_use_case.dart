import 'package:we/core/error/result.dart';
import 'package:we/data/models/auth/license/send_code_request.dart';
import 'package:we/domain/repositories/auth/license_repository.dart';

class SendCodeUseCase {
  final LicenseRepository _repository;
  SendCodeUseCase(this._repository);

  Future<Result<void>> call(SendCodeRequest request) async {
    return await _repository.sendCode(request);
  }
}