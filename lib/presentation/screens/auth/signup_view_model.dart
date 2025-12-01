import 'package:flutter/material.dart';
import 'package:we/core/error/failure.dart';
import 'package:we/data/models/auth/license/send_code_request.dart';
import 'package:we/data/models/auth/signup_request.dart';
import 'package:we/data/models/auth/license/verify_code_request.dart';
import 'package:we/domain/use_cases/auth/send_code_use_case.dart';
import 'package:we/domain/use_cases/auth/signup_use_case.dart';
import 'package:we/domain/use_cases/auth/verify_code_use_case.dart';

class SignUpViewModel extends ChangeNotifier {
  final SignupUseCase _signupUseCase;
  final SendCodeUseCase _sendCodeUseCase;
  final VerifyCodeUseCase _verifyCodeUseCase;

  SignUpViewModel(
      this._signupUseCase, this._sendCodeUseCase, this._verifyCodeUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _signupSuccess = false;
  bool get signupSuccess => _signupSuccess;

  Future<void> signup({
    required String userId,
    required String email,
    required String password,
    required String memberName,
    required String phone,
    String? referredBy,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _signupSuccess = false;
    notifyListeners();

    final request = SignupRequest(
      userId: userId,
      email: email,
      password: password,
      memberName: memberName,
      phone: phone,
      referredBy: referredBy,
    );

    final result = await _signupUseCase(request);

    result.when(
      success: (_) {
        _signupSuccess = true;
        _errorMessage = null;
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _signupSuccess = false;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendCode(String email) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final request = SendCodeRequest(email: email);
    final result = await _sendCodeUseCase(request);

    result.when(
      success: (_) {
        _errorMessage = null;
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> verifyCode(String email, String code) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final request = VerifyCodeRequest(email: email, code: code);
    final result = await _verifyCodeUseCase(request);

    result.when(
      success: (_) {
        _errorMessage = null;
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  void clearErrorMessage() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _signupSuccess = false;
    notifyListeners();
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
