import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:we/core/error/failure.dart';
import 'package:we/core/error/http_exception.dart';
import 'package:we/core/error/result.dart';
import 'package:we/core/error/error_extractor.dart'; // Import the new error extractor
import 'package:we/data/models/auth/license/send_code_request.dart';
import 'package:we/data/models/auth/license/verify_code_request.dart';
import 'package:we/data/models/common/api_response.dart';
import 'package:we/domain/repositories/auth/auth_repository.dart';
import 'package:we/data/api/auth/auth_api.dart';
import 'package:we/data/models/auth/change_password_request.dart';
import 'package:we/data/models/auth/login_request.dart';
import 'package:we/data/models/auth/login_response.dart';
import 'package:we/data/models/auth/refresh_response.dart';
import 'package:we/data/models/auth/signup_request.dart';
import 'package:we/core/auth/token_provider.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;
  final TokenProvider tokenProvider;

  AuthRepositoryImpl(this.authApi, this.tokenProvider);

  @override
  Future<Result<void>> signup(SignupRequest request) async {
    try {
      debugPrint('Signup request: ${request.toJson()}');
      final response = await authApi.signup(request.toJson());
      debugPrint('Signup raw response: $response');
      debugPrint('Signup success');
      return Result.success(null);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      debugPrint('Signup CustomHttpException: $errorMessage');
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e, stackTrace) {
      debugPrint('Signup error: ${e.toString()}');
      debugPrint('Signup error type: ${e.runtimeType}');
      debugPrint('Signup stack trace: $stackTrace');
      return Result.failure(
        ServerFailure('회원가입 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<LoginResponseData>> login(LoginRequest request) async {
    try {
      debugPrint('Login request: ${request.toJson()}');
      final response = await authApi.login(request.toJson());
      debugPrint('Login raw response: $response');
      final loginData = ApiResponse.fromJson(response, (dataJson) {
        debugPrint('Login data json: $dataJson');
        return LoginResponseData.fromJson(dataJson);
      });
      debugPrint('Login success');
      return Result.success(loginData.data);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      debugPrint('Login CustomHttpException: $errorMessage');
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e, stackTrace) {
      debugPrint('Login error: ${e.toString()}');
      debugPrint('Login error type: ${e.runtimeType}');
      debugPrint('Login stack trace: $stackTrace');
      return Result.failure(ServerFailure('로그인 중 오류가 발생했습니다: ${e.toString()}'));
    }
  }

  @override
  Future<Result<RefreshResponseData>> refresh(String refreshToken) async {
    try {
      final response = await authApi.refresh({'refresh_token': refreshToken});
      final refreshData = RefreshResponseData.fromJson(response);
      return Result.success(refreshData);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('토큰 갱신 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<void>> changePassword(ChangePasswordRequest request) async {
    try {
      await authApi.changePassword(request.toJson());
      return Result.success(null);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('비밀번호 변경 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await tokenProvider.clearTokens();
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheFailure('로그아웃 중 오류가 발생했습니다: ${e.toString()}'));
    }
  }

  Future<Result<void>> sendCode(SendCodeRequest request) async {
    try {
      await authApi.sendCode(request.toJson());
      return Result.success(null);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('인증번호 전송 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  Future<Result<void>> verifyCode(VerifyCodeRequest request) async {
    try {
      await authApi.verifyCode(request.toJson());
      return Result.success(null);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('인증번호 확인 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
