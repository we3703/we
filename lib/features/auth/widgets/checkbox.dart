import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we/core/config/constant.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/theme/typography.dart';
import 'package:we/core/theme/radius.dart';

class CustomCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomCheckbox({
    super.key,
    required this.label,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: value ? AppColors.primaryDefault : AppColors.surface,
              border: Border.all(
                color: value ? AppColors.primaryDefault : AppColors.border,
              ),
              borderRadius: AppRadius.sm,
            ),
            child: value
                ? Center(
                    child: SvgPicture.asset(
                      AppConstant.checkIcon,
                      width: 16,
                      height: 16,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.space8),
          Expanded(child: Text(label, style: AppTextStyles.subRegular)),
        ],
      ),
    );
  }
}
