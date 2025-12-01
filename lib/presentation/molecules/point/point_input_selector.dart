import 'package:flutter/material.dart';
import 'package:we/presentation/atoms/buttons/secondary_button.dart';
import 'package:we/presentation/atoms/inputs/text_input.dart';
import 'package:we/presentation/foundations/spacing.dart';

class PointInputSelector extends StatelessWidget {
  final TextEditingController controller;
  final Function(int) onAmountSelected;

  const PointInputSelector({
    super.key,
    required this.controller,
    required this.onAmountSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInput(
          controller: controller,
          hintText: '충전할 금액 입력', // "Enter amount to charge"
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppSpacing.layoutPadding),
        Row(
          children: [
            Expanded(
              child: SecondaryButton(
                text: '+ 10,000원',
                onPressed: () => onAmountSelected(10000),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SecondaryButton(
                text: '+ 30,000원',
                onPressed: () => onAmountSelected(30000),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SecondaryButton(
                text: '+ 50,000원',
                onPressed: () => onAmountSelected(50000),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
