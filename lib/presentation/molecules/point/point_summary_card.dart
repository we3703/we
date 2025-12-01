import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';

class PointSummaryCard extends StatelessWidget {
  final String currentPoints;
  final VoidCallback? onChargePressed;

  const PointSummaryCard({
    super.key,
    required this.currentPoints,
    this.onChargePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.layoutPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '보유 포인트',
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentPoints,
                  style: AppTextStyles.heading3Bold.copyWith(
                    color: AppColors.primaryBlack,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 100, // Fixed width for button
              child: PrimaryButton(text: '포인트 충전', onPressed: onChargePressed),
            ),
          ],
        ),
      ),
    );
  }
}
