import 'package:flutter/material.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/radius.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/theme/typography.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onMoreTap;

  const SectionHeader({super.key, required this.title, this.onMoreTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.layoutPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.heading3Medium),
          if (onMoreTap != null)
            ElevatedButton(
              onPressed: onMoreTap,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: AppRadius.sm),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.space8,
                  vertical: AppSpacing.space4,
                ),
                backgroundColor: AppColors.subSurface,
              ),
              child: Text("더보기", style: AppTextStyles.subRegular),
            ),
        ],
      ),
    );
  }
}
