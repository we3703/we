import 'package:flutter/material.dart';
import 'package:we/core/utils/number_formatter.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/shadows.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/atoms/tags/tag.dart';

class DetailSection {
  final String title;
  final List<String> items;

  DetailSection({required this.title, required this.items});
}

class ProductDetailCard extends StatelessWidget {
  final String? category;
  final String title;
  final int price;
  final String? remaining;
  final List<DetailSection> sections;

  const ProductDetailCard({
    super.key,
    this.category,
    required this.title,
    required this.price,
    this.remaining,
    required this.sections,
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
        padding: const EdgeInsets.all(AppSpacing.layoutPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (category != null) ...[
              CustomTag(label: category!),
              const SizedBox(height: 12),
            ],
            Text(
              title,
              style: AppTextStyles.heading3Bold.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${formatNumber(price)} P',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryGreen,
                  ),
                ),
                if (remaining != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    remaining!,
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.textDisabled,
                    ),
                  ),
                ],
              ],
            ),
            const Divider(height: 32),
            ...sections.map((section) => _buildSection(section)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(DetailSection section) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(section.title, style: AppTextStyles.bodyBold),
          const SizedBox(height: 8),
          ...section.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0, left: 8.0),
              child: Text(
                '• $item',
                style: AppTextStyles.bodyRegular.copyWith(height: 1.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
