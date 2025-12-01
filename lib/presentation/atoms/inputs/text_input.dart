import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';

class TextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorMessage;
  final bool isRequired;
  final bool obscureText;
  final bool enabled;
  final bool hasBorder;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final int? maxLength;

  const TextInput({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.errorMessage,
    this.isRequired = false,
    this.obscureText = false,
    this.enabled = true,
    this.hasBorder = true,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;

    InputDecoration decoration = const InputDecoration()
        .applyDefaults(inputTheme)
        .copyWith(hintText: hintText, errorText: errorMessage, counterText: '');

    if (!hasBorder) {
      decoration = decoration.copyWith(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        fillColor: Colors.transparent,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null && labelText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: RichText(
              text: TextSpan(
                text: labelText,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                children: [
                  if (isRequired)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: AppColors.error),
                    ),
                ],
              ),
            ),
          ),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLength: maxLength,
          style: AppTextStyles.bodyRegular.copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: decoration,
        ),
      ],
    );
  }
}
