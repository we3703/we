import 'package:we/core/api/error/failure.dart';
import 'package:we/data/models/auth/login_request.dart';
import 'package:we/domain/entities/auth/login_entity.dart';
import 'package:we/domain/use_cases/auth/login_use_case.dart';
import 'package:we/core/auth/token_provider.dart';
import 'package:we/presentation/screens/user/user_view_model.dart';

class LoginViewModel {
  final LoginUseCase _loginUseCase;
  final TokenProvider _tokenProvider;
  final UserViewModel _userViewModel;

  LoginViewModel(this._loginUseCase, this._tokenProvider, this._userViewModel);

  Future<LoginEntity> login(String userId, String password) async {
    final request = LoginRequest(userId: userId, password: password);
    final result = await _loginUseCase(request);

    return await result.when(
      success: (loginEntity) async {
        await _tokenProvider.setTokens(
          loginEntity.tokens.accessToken,
          loginEntity.tokens.refreshToken,
          loginEntity.user.role ?? 'USER',
        );
        _userViewModel.setUserFromLogin(loginEntity.user);
        return loginEntity;
      },
      failure: (failure) {
        throw Exception(_mapFailureToMessage(failure));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case ServerFailure _:
        return '서버 오류가 발생했습니다.';
      case NetworkFailure _:
        return '네트워크 연결을 확인해주세요.';
      case UnauthorizedFailure _:
        return '아이디 또는 비밀번호가 잘못되었습니다.';
      default:
        return failure.message;
    }
  }
}
