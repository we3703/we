import 'package:flutter/material.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/typography.dart';
import 'package:we/core/theme/radius.dart';

class CustomInput extends StatelessWidget {
  final String? placeholder;
  final String? errorMessage;
  final TextEditingController? controller;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final bool obscureText;

  const CustomInput({
    super.key,
    this.placeholder,
    this.errorMessage,
    this.controller,
    this.enabled = true,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.obscureText = false,
  });

  // TODO: app_theme 새로 적용 이후 개편하기
  @override
  Widget build(BuildContext context) {
    final bool hasError = errorMessage != null && errorMessage!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            TextField(
              controller: controller,
              enabled: enabled,
              onChanged: onChanged,
              onTap: onTap,
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: AppTextStyles.bodyRegular.copyWith(
                color: enabled ? AppColors.textPrimary : AppColors.textDisabled,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: AppTextStyles.bodyRegular.copyWith(
                  color: AppColors.textDisabled,
                ),
                filled: !enabled,
                fillColor: !enabled ? AppColors.subSurface : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                // unfocused 상태
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppRadius.md,
                  borderSide: BorderSide(
                    color: hasError ? AppColors.error : AppColors.border,
                    width: hasError ? 1.5 : 1.0,
                  ),
                ),
                // focused 상태
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppRadius.md,
                  borderSide: BorderSide(
                    color: hasError
                        ? AppColors.error
                        : AppColors.primaryDefault,
                    width: 1.5,
                  ),
                ),
                // disabled 상태
                disabledBorder: OutlineInputBorder(
                  borderRadius: AppRadius.md,
                  borderSide: const BorderSide(
                    color: AppColors.border,
                    width: 1.0,
                  ),
                ),
                // error focused 상태
                errorBorder: OutlineInputBorder(
                  borderRadius: AppRadius.md,
                  borderSide: const BorderSide(
                    color: AppColors.error,
                    width: 1.5,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: AppRadius.md,
                  borderSide: const BorderSide(
                    color: AppColors.error,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            if (hasError) ...[
              const SizedBox(height: 4),
              Text(
                errorMessage!,
                style: AppTextStyles.subRegular.copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
