import 'package:flutter/material.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/theme/typography.dart';

class NoticeCard extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback? onTap;
  final bool isFirst;

  const NoticeCard({
    super.key,
    required this.title,
    required this.date,
    this.onTap,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.space12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: isFirst
                ? const BorderSide(
                    color: AppColors.border,
                    width: 1,
                  )
                : BorderSide.none,
            bottom: const BorderSide(
              color: AppColors.border,
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.bodyMedium
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              date,
              style: AppTextStyles.subRegular.copyWith(
                color: AppColors.textSecondary
              )
            ),
          ],
        ),
      ),
    );
  }
}
