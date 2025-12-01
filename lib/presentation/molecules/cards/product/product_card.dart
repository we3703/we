import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/shadows.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/foundations/image_radio.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/atoms/buttons/link_button.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String productDescription;
  final String price;
  final VoidCallback? onDetailsPressed;
  final String? quantityRemaining; // Added from image
  final bool showQuantityRemaining; // Added from image

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.productDescription,
    required this.price,
    this.onDetailsPressed,
    this.quantityRemaining,
    this.showQuantityRemaining = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDetailsPressed,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
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
                borderRadius: BorderRadius.circular(
                  8.0,
                ), // Smaller radius for mini card image
                child: AppImage(
                  imageUrl: imageUrl,
                  ratioType: ImageRatioType.ratio1x1,
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
                  Text(
                    productDescription,
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.textDisabled,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (onDetailsPressed != null)
                        LinkButton(text: '상세보기', onPressed: onDetailsPressed),
                      const Spacer(),
                      Text(
                        price,
                        style: AppTextStyles.bodyBold.copyWith(
                          color: AppColors.primaryBlack,
                          fontSize: 12,
                        ),
                      ),
                      if (quantityRemaining != null) ...[
                        const SizedBox(width: AppSpacing.space8),
                        Text(
                          quantityRemaining!,
                          style: AppTextStyles.bodyRegular.copyWith(
                            color: AppColors.textDisabled,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
