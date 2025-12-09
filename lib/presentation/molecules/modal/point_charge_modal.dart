import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/point/point_input_selector.dart';

class PointChargeModal extends StatefulWidget {
  final Function(int) onConfirm;
  final VoidCallback onCancel;
  final bool isCharging;

  const PointChargeModal({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    this.isCharging = false,
  });

  @override
  State<PointChargeModal> createState() => _PointChargeModalState();
}

class _PointChargeModalState extends State<PointChargeModal> {
  final TextEditingController _controller = TextEditingController();
  int _selectedAmount = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleAmountSelected(int amount) {
    setState(() {
      _selectedAmount = (_selectedAmount + amount);
      _controller.text = _selectedAmount.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            DefaultTextStyle(
              style: AppTextStyles.heading3Bold,
              textAlign: TextAlign.center,
              child: const Text('포인트 충전'),
            ),
            const SizedBox(height: AppSpacing.space20),
            // Content
            PointInputSelector(
              controller: _controller,
              onAmountSelected: _handleAmountSelected,
            ),
            const SizedBox(height: AppSpacing.space32),
            // Actions
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: widget.isCharging ? null : widget.onCancel,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: AppColors.border),
                      ),
                    ),
                    child: const Text('취소'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.isCharging
                        ? null
                        : () {
                            final amount = int.tryParse(_controller.text) ?? 0;
                            if (amount > 0) {
                              widget.onConfirm(amount);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: widget.isCharging
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('충전하기'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function
Future<void> showPointChargeModal({
  required BuildContext context,
  required Function(int) onConfirm,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PointChargeModal(
      onConfirm: onConfirm,
      onCancel: () => Navigator.of(context).pop(),
    ),
  );
}
