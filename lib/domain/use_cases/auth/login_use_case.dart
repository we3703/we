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
            email: loginResponseData.user.email,
            name: loginResponseData.user.name,
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
