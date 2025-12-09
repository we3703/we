import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  const LinkButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        TextButton.styleFrom(
          foregroundColor: AppColors.primaryBlack,
          disabledForegroundColor: AppColors.textDisabled,
          textStyle:
              AppTextStyles.bodyRegular, // Using bodyRegular for link text
          padding: EdgeInsets.zero, // Remove default padding
          minimumSize: Size.zero, // Allow button to size itself to its children
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap target
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return AppColors.primaryBlack.withValues(alpha: 0.1);
            }
            return null; // Defer to the widget's default.
          }),
        );

    if (icon != null) {
      return TextButton.icon(
        style: style,
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: AppColors.primaryBlack,
                  strokeWidth: 2,
                ),
              )
            : Icon(icon, size: 16),
        label: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
      );
    }

    return TextButton(
      style: style,
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                color: AppColors.primaryBlack,
                strokeWidth: 2,
              ),
            )
          : Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
