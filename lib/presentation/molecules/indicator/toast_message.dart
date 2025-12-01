import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/foundations/spacing.dart';

class ToastMessage extends StatelessWidget {
  final String message;

  const ToastMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.layoutPadding,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.toast, // From colors.dart, a dark color
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        message,
        style: AppTextStyles.bodyRegular.copyWith(color: AppColors.surface),
      ),
    );
  }
}
