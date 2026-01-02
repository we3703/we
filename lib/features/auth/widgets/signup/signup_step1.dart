import 'package:flutter/material.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/widgets/input/custom_input.dart';
import 'package:we/core/widgets/button/primary_button.dart';

class SignupStep1 extends StatelessWidget {
  final TextEditingController userIdController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final String? passwordError;
  final bool isValid;
  final bool isLoading;
  final VoidCallback onNext;

  const SignupStep1({
    super.key,
    required this.userIdController,
    required this.passwordController,
    required this.passwordConfirmController,
    this.passwordError,
    required this.isValid,
    required this.isLoading,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.space16),

          // User ID Input
          CustomInput(
            controller: userIdController,
            placeholder: '아이디를 입력해주세요.',
          ),
          const SizedBox(height: AppSpacing.space16),

          // Password Input
          CustomInput(
            controller: passwordController,
            placeholder: '비밀번호를 입력해주세요.',
            obscureText: true,
          ),
          const SizedBox(height: AppSpacing.space16),

          // Password Confirm Input
          CustomInput(
            controller: passwordConfirmController,
            placeholder: '비밀번호를 다시 입력해주세요.',
            obscureText: true,
            errorMessage: passwordError,
          ),
          const SizedBox(height: AppSpacing.space24),

          const Spacer(),

          // Next Button
          PrimaryButton(
            text: '다음 단계',
            onPressed: isValid && !isLoading ? onNext : null,
            variant: isValid && !isLoading
                ? ButtonVariant.primary
                : ButtonVariant.disabled,
          ),
        ],
      ),
    );
  }
}
