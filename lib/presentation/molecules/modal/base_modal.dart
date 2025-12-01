import 'package:flutter/material.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/atoms/buttons/secondary_button.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';

class BaseModal extends StatelessWidget {
  final Widget? title;
  final Widget content;
  final String? okText;
  final String? cancelText;
  final VoidCallback? onOk;
  final VoidCallback? onCancel;
  final bool isOkLoading;
  final bool isCancelLoading;
  final bool isOkDanger;

  const BaseModal({
    super.key,
    this.title,
    required this.content,
    this.okText,
    this.cancelText,
    this.onOk,
    this.onCancel,
    this.isOkLoading = false,
    this.isCancelLoading = false,
    this.isOkDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Stretch to fill width
          children: [
            // Title
            if (title != null) ...[
              DefaultTextStyle(
                style: AppTextStyles.heading3Bold,
                textAlign: TextAlign.center,
                child: title!,
              ),
              const SizedBox(height: AppSpacing.space20),
            ],
            // Content
            DefaultTextStyle(
              style: AppTextStyles.bodyRegular.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              child: content,
            ),
            // Actions
            if (onOk != null || onCancel != null) ...[
              const SizedBox(height: AppSpacing.space32),
              _buildActions(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        if (onCancel != null)
          Expanded(
            child: SecondaryButton(
              text: cancelText ?? '취소', // 'Cancel'
              onPressed: onCancel,
              isLoading: isCancelLoading,
            ),
          ),
        if (onOk != null && onCancel != null) const SizedBox(width: 8),
        if (onOk != null)
          Expanded(
            child: PrimaryButton(
              text: okText ?? '확인', // 'OK'
              onPressed: onOk,
              isLoading: isOkLoading,
            ),
          ),
      ],
    );
  }
}
