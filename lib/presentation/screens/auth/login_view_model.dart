import 'package:flutter/cupertino.dart';
import 'package:we/data/models/auth/login_request.dart';
import 'package:we/domain/entities/auth/login_entity.dart';
import 'package:we/domain/use_cases/auth/login_use_case.dart';
import 'package:we/presentation/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  LoginEntity? _loggedInUser;
  LoginEntity? get loggedInUser => _loggedInUser;

  Future<void> login(String email, String password) async {
    setLoading(true);
    clearError();

    try {
      final request = LoginRequest(email: email, password: password);
      final result = await _loginUseCase(request);

      result.when(
        success: (loginEntity) {
          _loggedInUser = loginEntity;
          setError(null);
        },
        failure: (failure) {
          setError(mapFailureToMessage(failure));
          _loggedInUser = null;
        },
      );
    } catch (e) {
      debugPrint("여기 오류에요 viewmodel");
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
