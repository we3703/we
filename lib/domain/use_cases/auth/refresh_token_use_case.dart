import 'package:we/core/error/result.dart';
import 'package:we/domain/entities/auth/token_entity.dart';
import 'package:we/domain/repositories/auth/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository _repository;

  RefreshTokenUseCase(this._repository);

  Future<Result<TokenEntity>> call(String refreshToken) async {
    final result = await _repository.refresh(refreshToken);
    return result.when(
      success: (refreshResponseData) {
        final tokenEntity = TokenEntity(
          accessToken: refreshResponseData.accessToken,
          refreshToken: refreshResponseData.refreshToken,
        );
        return Result.success(tokenEntity);
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
