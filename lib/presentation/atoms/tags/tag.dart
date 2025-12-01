import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';

class CustomTag extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final VoidCallback? onCancel;

  const CustomTag({
    super.key,
    required this.label,
    this.onPressed,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.bodyRegular.copyWith(
      fontSize: 14,
      color: AppColors.textPrimary,
    );

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.tag,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: textStyle),
            if (onCancel != null)
              InkWell(
                onTap: onCancel,
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
