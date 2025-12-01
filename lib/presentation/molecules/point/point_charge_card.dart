import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/point/point_input_selector.dart';

class PointChargeCard extends StatelessWidget {
  final TextEditingController controller;
  final Function(int) onAmountSelected;

  const PointChargeCard({
    super.key,
    required this.controller,
    required this.onAmountSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.layoutPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '충전 금액 선택', // "Select Charge Amount"
              style: AppTextStyles.bodyBold,
            ),
            const SizedBox(height: AppSpacing.layoutPadding),
            PointInputSelector(
              controller: controller,
              onAmountSelected: onAmountSelected,
            ),
          ],
        ),
      ),
    );
  }
}
