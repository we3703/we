import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';

enum PointTransactionType { charge, use, earning }

class PointHistoryRow extends StatelessWidget {
  final PointTransactionType type;
  final String date;
  final String amount;

  const PointHistoryRow({
    super.key,
    required this.type,
    required this.date,
    required this.amount,
  });

  String get _typeDisplayString {
    switch (type) {
      case PointTransactionType.charge:
        return '충전';
      case PointTransactionType.use:
        return '사용';
      case PointTransactionType.earning:
        return '수당';
    }
  }

  Color get _amountColor {
    switch (type) {
      case PointTransactionType.charge:
      case PointTransactionType.earning:
        return AppColors.primaryBlack;
      case PointTransactionType.use:
        return AppColors.error;
    }
  }

  String get _amountPrefix {
    switch (type) {
      case PointTransactionType.charge:
      case PointTransactionType.earning:
        return '+';
      case PointTransactionType.use:
        return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_typeDisplayString, style: AppTextStyles.bodyBold),
              const SizedBox(height: 4),
              Text(
                date,
                style: AppTextStyles.bodyRegular.copyWith(
                  color: AppColors.textDisabled,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            '$_amountPrefix$amount P',
            style: AppTextStyles.heading3Medium.copyWith(color: _amountColor),
          ),
        ],
      ),
    );
  }
}
