import 'package:flutter/material.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/radius.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/theme/typography.dart';

class ToastMessage extends StatelessWidget {
  final String message;

  const ToastMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space8,
      ),
      decoration: BoxDecoration(
        color: AppColors.toast.withValues(alpha: 0.85),
        borderRadius: AppRadius.md,
      ),
      child: Text(
        message,
        style: AppTextStyles.bodyRegular.copyWith(color: AppColors.surface),
      ),
    );
  }
}
