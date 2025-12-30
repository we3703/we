import 'package:flutter/material.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/theme/typography.dart';
import 'package:we/core/theme/radius.dart';

enum ButtonVariant { primary, disabled }

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final double? width;
  final double height;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.width,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color textColor;

    switch (variant) {
      case ButtonVariant.primary:
        borderColor = AppColors.primaryDefault;
        textColor = AppColors.primaryDefault;
        break;
      case ButtonVariant.disabled:
        borderColor = AppColors.border;
        textColor = AppColors.textDisabled;
        break;
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(borderRadius: AppRadius.md),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.surface,
            foregroundColor: textColor,
            side: BorderSide(color: borderColor, width: 1),
            disabledBackgroundColor: AppColors.subSurface,
            disabledForegroundColor: AppColors.textDisabled,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.space16,
              vertical: AppSpacing.space8,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
