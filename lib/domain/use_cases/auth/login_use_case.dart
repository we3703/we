import 'package:we/core/error/result.dart';
import 'package:we/data/models/auth/login_request.dart';
import 'package:we/domain/entities/auth/login_entity.dart';
import 'package:we/domain/entities/auth/token_entity.dart';
import 'package:we/domain/entities/user/user_entity.dart';
import 'package:we/domain/repositories/auth/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;
  LoginUseCase(this._repository);

  Future<Result<LoginEntity>> call(LoginRequest request) async {
    final result = await _repository.login(request);
    return result.when(
      success: (loginResponseData) {
        final loginEntity = LoginEntity(
          tokens: TokenEntity(
            accessToken: loginResponseData.tokens.accessToken,
            refreshToken: loginResponseData.tokens.refreshToken,
          ),
          user: UserEntity(
            userId: loginResponseData.user.userId,
            name: loginResponseData.user.name,
            phone: loginResponseData.user.phone,
            points: loginResponseData.user.points,
            level: loginResponseData.user.level,
            referrerId: loginResponseData.user.referrerId,
            referrerName: loginResponseData.user.referrerName,
            totalReferrals: loginResponseData.user.totalReferrals,
            createdAt: loginResponseData.user.createdAt,
            role: loginResponseData.user.role,
          ),
        );
        return Result.success(loginEntity);
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
