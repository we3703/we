import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';

class DangerButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  const DangerButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          disabledForegroundColor: AppColors.textDisabled,
          minimumSize: const Size.fromHeight(48), // Height 48px
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Default rounded corners
          ),
          side: const BorderSide(color: AppColors.error),
          textStyle: AppTextStyles.bodyBold, // Using bodyBold for button text
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return AppColors.error.withValues(alpha: 0.1);
            }
            return null; // Defer to the widget's default.
          }),
          side: WidgetStateProperty.resolveWith<BorderSide?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.disabled)) {
              return const BorderSide(color: AppColors.secondary);
            }
            return const BorderSide(color: AppColors.error);
          }),
        );

    if (icon != null) {
      return OutlinedButton.icon(
        style: style,
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.error,
                  strokeWidth: 2,
                ),
              )
            : Icon(icon, size: 20),
        label: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
      );
    }

    return OutlinedButton(
      style: style,
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: AppColors.error,
                strokeWidth: 2,
              ),
            )
          : Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
