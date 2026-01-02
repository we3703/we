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
    Color backgroundColor;
    Color textColor;
    BoxBorder? border;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = AppColors.primaryDefault;
        textColor = AppColors.textInverse;
        border = null;
        break;
      case ButtonVariant.disabled:
        backgroundColor = AppColors.subSurface;
        textColor = AppColors.textDisabled;
        border = Border.all(color: AppColors.border, width: 1);
        break;
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(borderRadius: AppRadius.md, border: border),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
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
