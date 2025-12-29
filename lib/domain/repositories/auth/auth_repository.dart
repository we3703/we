import 'package:we/core/api/error/result.dart';
import 'package:we/data/models/auth/change_password_request.dart';
import 'package:we/data/models/auth/login_request.dart';
import 'package:we/data/models/auth/login_response.dart';
import 'package:we/data/models/auth/refresh_response.dart';
import 'package:we/data/models/auth/signup_request.dart';

abstract class AuthRepository {
  /// Sign up a new user
  Future<Result<void>> signup(SignupRequest request);

  /// Login with email and password
  Future<Result<LoginResponseData>> login(LoginRequest request);

  /// Refresh access token using refresh token
  Future<Result<RefreshResponseData>> refresh(String refreshToken);

  /// Change user password
  Future<Result<void>> changePassword(ChangePasswordRequest request);

  /// Logout (clear local tokens)
  Future<Result<void>> logout();
}
