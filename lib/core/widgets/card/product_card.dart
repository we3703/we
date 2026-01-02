import 'package:flutter/material.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/radius.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/theme/typography.dart';
import 'package:we/core/utils/number_formatter.dart';

class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String description;
  final int? originalPrice;
  final int price;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.description,
    this.originalPrice,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.md,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지
            AspectRatio(
              aspectRatio: 1.6,
              child: imageUrl != null
                ? ClipRRect(
                    borderRadius: AppRadius.sm,
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                        );
                      },
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: AppRadius.sm,
                    )
                  ),
            ),
            // 정보
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.space8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      description,
                      style: AppTextStyles.subRegular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    if (originalPrice != null) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${(((originalPrice! - price) / originalPrice!) * 100).round()}%',
                            style: AppTextStyles.subRegular.copyWith(
                              color: AppColors.textSecondary
                            ),
                          ),
                          SizedBox(width: AppSpacing.space4),
                          Text(
                            '${formatNumber(originalPrice!)}P',
                            style: AppTextStyles.subRegular.copyWith(
                              color: AppColors.textDisabled,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColors.textDisabled,
                              decorationThickness: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                    Text(
                      '${formatNumber(price)}P',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primaryDefault
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
