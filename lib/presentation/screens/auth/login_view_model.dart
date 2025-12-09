import 'package:we/core/auth/token_provider.dart';
import 'package:we/data/models/auth/login_request.dart';
import 'package:we/domain/entities/auth/login_entity.dart';
import 'package:we/domain/use_cases/auth/login_use_case.dart';
import 'package:we/presentation/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final LoginUseCase _loginUseCase;
  final TokenProvider _tokenProvider;

  LoginViewModel(this._loginUseCase, this._tokenProvider);

  LoginEntity? _loggedInUser;
  LoginEntity? get loggedInUser => _loggedInUser;

  Future<void> login(String userId, String password) async {
    setLoading(true);
    clearError();

    try {
      final request = LoginRequest(userId: userId, password: password);
      final result = await _loginUseCase(request);

      await result.when(
        success: (loginEntity) async {
          _loggedInUser = loginEntity;
          await _tokenProvider.setTokens(
            loginEntity.tokens.accessToken,
            loginEntity.tokens.refreshToken,
          );
          setError(null);
        },
        failure: (failure) async {
          setError(mapFailureToMessage(failure));
          _loggedInUser = null;
        },
      );
    } catch (e) {
      setError('로그인 중 오류가 발생했습니다: ${e.toString()}');
      _loggedInUser = null;
    }

    setLoading(false);
  }

  void reset() {
    setLoading(false);
    clearError();
    _loggedInUser = null;
  }
}
