import 'package:flutter/material.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/radius.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/theme/typography.dart';
import 'package:we/core/utils/number_formatter.dart';

class PurchaseCard extends StatelessWidget {
  final String productName;
  final String date;
  final int price;
  final VoidCallback? onTap;

  const PurchaseCard({
    super.key,
    required this.productName,
    required this.date,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.space16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.md,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 5,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              style: AppTextStyles.bodyMedium
            ),
            const SizedBox(height: AppSpacing.space8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: AppTextStyles.subRegular.copyWith(
                    color: AppColors.textSecondary
                  )
                ),
                Text(
                  '${formatNumber(price)}P',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryDefault
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
