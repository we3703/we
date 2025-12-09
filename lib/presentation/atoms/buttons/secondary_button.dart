import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondaryLight,
      foregroundColor: AppColors.textPrimary,
      disabledBackgroundColor: AppColors.secondary,
      disabledForegroundColor: AppColors.textDisabled,
      minimumSize: const Size(0, 48), // Height 48px
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Default rounded corners
      ),
      textStyle: AppTextStyles.bodyBold, // Using bodyBold for button text
      elevation: 0, // No shadow by default
    );

    if (icon != null) {
      return ElevatedButton.icon(
        style: style,
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.textPrimary,
                  strokeWidth: 2,
                ),
              )
            : Icon(icon, size: 20),
        label: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
      );
    }

    return ElevatedButton(
      style: style,
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: AppColors.textPrimary,
                strokeWidth: 2,
              ),
            )
          : Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
