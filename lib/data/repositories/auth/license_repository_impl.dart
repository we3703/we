import 'dart:io';

import 'package:we/core/error/failure.dart';
import 'package:we/core/error/result.dart';
import 'package:we/core/error/http_exception.dart'; // Import CustomHttpException
import 'package:we/core/error/error_extractor.dart'; // Import the new error extractor
import 'package:we/data/models/auth/license/send_code_request.dart';
import 'package:we/data/models/auth/license/verify_code_request.dart';
import 'package:we/data/models/auth/license/verify_code_response.dart';
import 'package:we/domain/repositories/auth/license_repository.dart';
import 'package:we/data/api/auth/license_api.dart';
import 'package:we/data/models/auth/license/send_code_response.dart';

class LicenseRepositoryImpl implements LicenseRepository {
  final LicenseApi licenseApi;

  LicenseRepositoryImpl(this.licenseApi);

  @override
  Future<Result<LicenseCodeResponse>> sendCode(SendCodeRequest request) async {
    try {
      final response = await licenseApi.sendCode(request.toJson());
      final codeResponse = LicenseCodeResponse.fromJson(response);
      return Result.success(codeResponse);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      // Changed from HttpException
      final errorMessage = extractErrorMessage(e);
      return Result.failure(
        ServerFailure(errorMessage, e.statusCode), // Use e.statusCode
      );
    } catch (e) {
      return Result.failure(
        ServerFailure('인증 코드 전송 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<LicenseVerifyResponse>> verifyCode(
    VerifyCodeRequest request,
  ) async {
    try {
      final response = await licenseApi.verifyCode(request.toJson());
      final verifyResponse = LicenseVerifyResponse.fromJson(response);
      return Result.success(verifyResponse);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      // Changed from HttpException
      final errorMessage = extractErrorMessage(e);
      if (e.message.contains('400')) {
        // This part might need refinement depending on actual error structure
        return Result.failure(const ValidationFailure('유효하지 않은 인증 코드입니다'));
      }
      return Result.failure(
        ServerFailure(errorMessage, e.statusCode), // Use e.statusCode
      );
    } catch (e) {
      return Result.failure(
        ServerFailure('인증 코드 확인 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
