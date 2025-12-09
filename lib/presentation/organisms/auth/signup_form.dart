import 'package:flutter/material.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/atoms/inputs/text_input.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';

class SignUpForm extends StatefulWidget {
  final Function(
    String id,
    String password,
    String name,
    String phone,
    String? referralCode,
  )
  onSignUp;
  final bool isLoading;

  const SignUpForm({super.key, required this.onSignUp, this.isLoading = false});

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _referralCodeController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _referralCodeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSignUp(
        _idController.text,
        _passwordController.text,
        _nameController.text,
        _phoneController.text,
        _referralCodeController.text.isNotEmpty
            ? _referralCodeController.text
            : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLabeledInput(
            label: '아이디',
            child: TextInput(
              controller: _idController,
              hintText: '아이디 입력',
              keyboardType: TextInputType.text,
              maxLength: 15,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '아이디를 입력해주세요.';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: AppSpacing.space20),
          _buildLabeledInput(
            label: '비밀번호',
            child: TextInput(
              controller: _passwordController,
              hintText: '비밀번호 입력',
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력해주세요.';
                }
                final regex = RegExp(
                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$',
                );
                if (!regex.hasMatch(value)) {
                  return '비밀번호는 8~20자이며, 영문 대/소문자, 숫자, 특수문자를 포함해야 합니다.';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: AppSpacing.space20),
          _buildLabeledInput(
            label: '비밀번호 확인',
            child: TextInput(
              controller: _passwordConfirmController,
              hintText: '비밀번호 확인',
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 다시 입력해주세요.';
                }
                if (value != _passwordController.text) {
                  return '비밀번호가 일치하지 않습니다.';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: AppSpacing.space20),
          _buildLabeledInput(
            label: '이름',
            child: TextInput(
              controller: _nameController,
              hintText: '이름 입력',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이름을 입력해주세요.';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: AppSpacing.space20),
          _buildLabeledInput(
            label: '전화번호',
            child: TextInput(
              controller: _phoneController,
              hintText: '전화번호 입력',
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '전화번호를 입력해주세요.';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: AppSpacing.space20),
          _buildLabeledInput(
            label: '추천인 코드 (선택)',
            child: TextInput(
              controller: _referralCodeController,
              hintText: '추천인 코드 입력',
            ),
          ),
          const SizedBox(height: AppSpacing.space32),
          PrimaryButton(
            text: '가입하기',
            onPressed: _submit,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledInput({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodyBold),
        const SizedBox(height: AppSpacing.space12),
        child,
      ],
    );
  }
}
