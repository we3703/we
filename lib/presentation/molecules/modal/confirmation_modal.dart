import 'package:flutter/material.dart';
import 'package:we/presentation/molecules/modal/base_modal.dart';

class ConfirmationModal extends StatelessWidget {
  final String title;
  final String content;
  final String okText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool isConfirming;
  final bool isDanger;

  const ConfirmationModal({
    super.key,
    required this.title,
    required this.content,
    this.okText = '확인',
    this.cancelText = '취소',
    required this.onConfirm,
    required this.onCancel,
    this.isConfirming = false,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return BaseModal(
      title: Text(title),
      content: Text(content),
      okText: okText,
      cancelText: cancelText,
      onOk: onConfirm,
      onCancel: onCancel,
      isOkLoading: isConfirming,
      isOkDanger: isDanger,
    );
  }
}

// Helper function to show the dialog
Future<void> showConfirmationModal({
  required BuildContext context,
  required String title,
  required String content,
  String okText = '확인',
  String cancelText = '취소',
  required VoidCallback onConfirm,
  bool isDanger = false,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return ConfirmationModal(
        title: title,
        content: content,
        okText: okText,
        cancelText: cancelText,
        onConfirm: () {
          onConfirm();
          Navigator.of(context).pop(); // Close dialog on confirm
        },
        onCancel: () => Navigator.of(context).pop(), // Close dialog on cancel
        isDanger: isDanger,
      );
    },
  );
}
