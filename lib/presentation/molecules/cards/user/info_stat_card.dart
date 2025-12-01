import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/foundations/spacing.dart';

class InfoStatItem {
  final String title;
  final String value;

  InfoStatItem({required this.title, required this.value});
}

class InfoStatCard extends StatelessWidget {
  final String title;
  final List<InfoStatItem> stats;

  const InfoStatCard({super.key, required this.title, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.layoutPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.bodyBold.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.layoutPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: stats.map((stat) {
                return Expanded(
                  child: Column(
                    children: [
                      Text(
                        stat.title,
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.textDisabled,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stat.value,
                        style: AppTextStyles.heading3Bold.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
