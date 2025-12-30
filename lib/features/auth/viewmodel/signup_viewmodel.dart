import 'package:we/core/api/error/failure.dart';
import 'package:we/data/models/auth/signup_request.dart';
import 'package:we/domain/use_cases/auth/signup_use_case.dart';

class SignUpViewModel {
  final SignupUseCase _signupUseCase;

  SignUpViewModel(this._signupUseCase);

  Future<void> signup({
    required String userId,
    required String password,
    required String memberName,
    required String phone,
    String? referredBy,
  }) async {
    final request = SignupRequest(
      userId: userId,
      password: password,
      memberName: memberName,
      phone: phone,
      referredBy: referredBy,
    );

    final result = await _signupUseCase(request);

    return await result.when(
      success: (_) {
        // Success - no exception thrown
      },
      failure: (failure) {
        throw Exception(_mapFailureToMessage(failure));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
