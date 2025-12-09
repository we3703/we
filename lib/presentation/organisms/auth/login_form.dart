import 'package:flutter/material.dart';
import 'package:we/presentation/atoms/buttons/link_button.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/atoms/inputs/text_input.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';

class LoginForm extends StatefulWidget {
  final Function(String id, String password) onLogin;
  final VoidCallback onSignUp;
  final bool isLoading;
  final String? errorMessage;

  const LoginForm({
    super.key,
    required this.onLogin,
    required this.onSignUp,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('아이디', style: AppTextStyles.bodyBold),
        const SizedBox(height: AppSpacing.space12),
        TextInput(
          controller: _idController,
          hintText: '아이디 입력',
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: AppSpacing.space20),
        Text('비밀번호', style: AppTextStyles.bodyBold),
        const SizedBox(height: AppSpacing.space12),
        TextInput(
          controller: _passwordController,
          hintText: '비밀번호 입력',
          obscureText: true,
        ),
        if (widget.errorMessage != null)
          Padding(
            padding: EdgeInsets.only(top: AppSpacing.space12),
            child: Text(
              widget.errorMessage!,
              style: AppTextStyles.subRegular.copyWith(color: AppColors.error),
              textAlign: TextAlign.center,
            ),
          ),
        const SizedBox(height: AppSpacing.space32),
        PrimaryButton(
          text: '로그인',
          onPressed: () =>
              widget.onLogin(_idController.text, _passwordController.text),
          isLoading: widget.isLoading,
        ),
        const SizedBox(height: AppSpacing.space20),
        Align(
          alignment: Alignment.center,
          child: LinkButton(
            text: '회원가입', // "Sign Up"
            onPressed: widget.onSignUp,
          ),
        ),
      ],
    );
  }
}
