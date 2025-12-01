import 'package:flutter/material.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/atoms/inputs/text_input.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';

class UserInfoForm extends StatefulWidget {
  final String initialName;
  final String initialPhone;
  final bool isLoading;
  final Function(
    String name,
    String phone,
    String? oldPassword,
    String? newPassword,
  )
  onSave;

  const UserInfoForm({
    super.key,
    required this.initialName,
    required this.initialPhone,
    this.isLoading = false,
    required this.onSave,
  });

  @override
  State<UserInfoForm> createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _phoneController = TextEditingController(text: widget.initialPhone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordConfirmController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSave(
        _nameController.text,
        _phoneController.text,
        _oldPasswordController.text.isNotEmpty
            ? _oldPasswordController.text
            : null,
        _newPasswordController.text.isNotEmpty
            ? _newPasswordController.text
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
        // Basic Info Section
        Text('기본 정보', style: AppTextStyles.heading3Bold),
        const SizedBox(height: AppSpacing.space12),
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
        const SizedBox(height: AppSpacing.space32),

        // Password Change Section
        Text('비밀번호 변경', style: AppTextStyles.heading3Bold),
        const SizedBox(height: AppSpacing.space12),
        _buildLabeledInput(
          label: '기존 비밀번호',
          child: TextInput(
            controller: _oldPasswordController,
            hintText: '기존 비밀번호 입력',
            obscureText: true,
            validator: (value) {
              // 새 비밀번호를 입력했다면 기존 비밀번호도 필수
              if (_newPasswordController.text.isNotEmpty) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 변경하려면 기존 비밀번호를 입력해주세요.';
                }
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: AppSpacing.space20),
        _buildLabeledInput(
          label: '새 비밀번호',
          child: TextInput(
            controller: _newPasswordController,
            hintText: '새 비밀번호 입력',
            obscureText: true,
            validator: (value) {
              // 새 비밀번호를 입력했다면 유효성 검증
              if (value != null && value.isNotEmpty) {
                final regex = RegExp(
                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$',
                );
                if (!regex.hasMatch(value)) {
                  return '비밀번호는 8~20자이며, 영문 대/소문자, 숫자, 특수문자를 포함해야 합니다.';
                }
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: AppSpacing.space20),
        _buildLabeledInput(
          label: '새 비밀번호 확인',
          child: TextInput(
            controller: _newPasswordConfirmController,
            hintText: '새 비밀번호 확인',
            obscureText: true,
            validator: (value) {
              // 새 비밀번호를 입력했다면 확인도 필수
              if (_newPasswordController.text.isNotEmpty) {
                if (value == null || value.isEmpty) {
                  return '새 비밀번호를 다시 입력해주세요.';
                }
                if (value != _newPasswordController.text) {
                  return '비밀번호가 일치하지 않습니다.';
                }
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: AppSpacing.space32),

        // Save Button
        PrimaryButton(
          text: '저장하기',
          onPressed: _handleSave,
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
