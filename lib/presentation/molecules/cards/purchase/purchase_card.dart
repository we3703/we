import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/shadows.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/foundations/image_radio.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart'; // For repurchase button

class PurchaseCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final int price;
  final String? purchaseDate; // For "구매일"
  final VoidCallback? onRepurchasePressed; // For "재구매" button

  const PurchaseCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    this.purchaseDate,
    this.onRepurchasePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: AppShadow.card,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            SizedBox(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: AppImage(
                  imageUrl: imageUrl,
                  ratioType: ImageRatioType
                      .ratio1x1, // A common ratio for product images
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.layoutPadding),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: AppTextStyles.bodyBold.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (purchaseDate != null)
                        Flexible(
                          child: Text(
                            '구매일 $purchaseDate',
                            style: AppTextStyles.bodyRegular.copyWith(
                              color: AppColors.textDisabled,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Row(
                    children: [
                      SizedBox(
                        width: 80, // Make button full width
                        height: 32,
                        child: PrimaryButton(
                          text: '재구매',
                          onPressed: onRepurchasePressed,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.space12),
                      Text(
                        '$price P',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primaryBlack,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
