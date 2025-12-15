import 'package:flutter/material.dart';
import 'package:we/core/utils/number_formatter.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/modal/base_modal.dart';

class PurchaseConfirmModal extends StatelessWidget {
  final String productName;
  final int price;
  final int pointsAfterPurchase;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool isConfirming;

  const PurchaseConfirmModal({
    super.key,
    required this.productName,
    required this.price,
    required this.pointsAfterPurchase,
    required this.onConfirm,
    required this.onCancel,
    this.isConfirming = false,
  });

  @override
  Widget build(BuildContext context) {
    return BaseModal(
      title: Text('구매하시겠습니까?', style: TextStyle(color: AppColors.textPrimary)),
      content: Column(
        children: [
          _buildInfoRow('상품명', productName),
          const SizedBox(height: 8),
          _buildInfoRow('가격', '${formatNumber(price)} P'),
          const SizedBox(height: 8),
          _buildInfoRow(
            '구매 후 포인트',
            '${formatNumber(pointsAfterPurchase)} P',
            highlight: true,
          ),
        ],
      ),
      okText: '구매하기',
      cancelText: '취소',
      onOk: onConfirm,
      onCancel: onCancel,
      isOkLoading: isConfirming,
    );
  }

  Widget _buildInfoRow(String title, String value, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyRegular.copyWith(
            color: AppColors.textDisabled,
          ),
        ),
        Text(
          value,
          style: highlight
              ? AppTextStyles.bodyBold.copyWith(color: AppColors.primaryGreen)
              : AppTextStyles.bodyRegular.copyWith(
                  color: AppColors.textPrimary,
                ),
        ),
      ],
    );
  }
}

// Helper function
Future<void> showPurchaseConfirmModal({
  required BuildContext context,
  required String productName,
  required int price,
  required int pointsAfterPurchase,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (context) => PurchaseConfirmModal(
      productName: productName,
      price: price,
      pointsAfterPurchase: pointsAfterPurchase,
      onConfirm: () {
        onConfirm();
        Navigator.of(context).pop();
      },
      onCancel: () => Navigator.of(context).pop(),
    ),
  );
}
