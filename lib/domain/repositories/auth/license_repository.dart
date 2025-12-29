import 'package:we/core/api/error/result.dart';
import 'package:we/data/models/auth/license/send_code_request.dart';
import 'package:we/data/models/auth/license/send_code_response.dart';
import 'package:we/data/models/auth/license/verify_code_request.dart';
import 'package:we/data/models/auth/license/verify_code_response.dart';

/// License Repository Interface
abstract class LicenseRepository {
  /// Send verification code to email
  Future<Result<LicenseCodeResponse>> sendCode(SendCodeRequest request);

  /// Verify license code
  Future<Result<LicenseVerifyResponse>> verifyCode(VerifyCodeRequest request);
}
