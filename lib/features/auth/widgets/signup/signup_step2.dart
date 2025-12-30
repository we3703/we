import 'package:flutter/material.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/theme/typography.dart';
import 'package:we/core/widgets/custom_input.dart';
import 'package:we/core/widgets/primary_button.dart';
import 'package:we/core/widgets/cancel_button.dart' as cancel;
import 'package:we/features/auth/widgets/checkbox.dart';

class SignupStep2 extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController referredByController;
  final bool agreedToTerms;
  final ValueChanged<bool> onTermsChanged;
  final VoidCallback onShowTerms;
  final bool isValid;
  final bool isLoading;
  final VoidCallback onPrevious;
  final VoidCallback onSignup;

  const SignupStep2({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.referredByController,
    required this.agreedToTerms,
    required this.onTermsChanged,
    required this.onShowTerms,
    required this.isValid,
    required this.isLoading,
    required this.onPrevious,
    required this.onSignup,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.space16),

          // Name Input
          CustomInput(
            controller: nameController,
            placeholder: '이름을 입력해주세요.',
          ),
          const SizedBox(height: AppSpacing.space16),

          // Phone Input
          CustomInput(
            controller: phoneController,
            placeholder: '전화번호를 입력해주세요.',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppSpacing.space16),

          // Referred By Input
          CustomInput(
            controller: referredByController,
            placeholder: '추천인 코드를 입력해주세요. (선택)',
          ),
          const SizedBox(height: AppSpacing.space24),

          // Terms Agreement
          Row(
            children: [
              Expanded(
                child: CustomCheckbox(
                  value: agreedToTerms,
                  label: '(필수) 개인정보 수집 및 이용 동의',
                  onChanged: onTermsChanged,
                ),
              ),
              GestureDetector(
                onTap: onShowTerms,
                child: Text(
                  '[보기]',
                  style: AppTextStyles.subMedium.copyWith(
                    color: AppColors.primaryDefault,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Buttons
          Row(
            children: [
              // Previous Button
              Expanded(
                child: cancel.PrimaryButton(
                  text: '이전 단계',
                  onPressed: !isLoading ? onPrevious : null,
                  variant: !isLoading
                      ? cancel.ButtonVariant.primary
                      : cancel.ButtonVariant.disabled,
                ),
              ),
              const SizedBox(width: AppSpacing.space8),
              // Signup Button
              Expanded(
                child: PrimaryButton(
                  text: isLoading ? '가입 중...' : '회원가입',
                  onPressed: isValid && !isLoading ? onSignup : null,
                  variant: isValid && !isLoading
                      ? ButtonVariant.primary
                      : ButtonVariant.disabled,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
