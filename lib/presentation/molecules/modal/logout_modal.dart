import 'package:flutter/material.dart';
import 'package:we/presentation/molecules/modal/confirmation_modal.dart';

class LogoutModal extends StatelessWidget {
  final VoidCallback onLogout;
  final bool isLoggingOut;

  const LogoutModal({
    super.key,
    required this.onLogout,
    this.isLoggingOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConfirmationModal(
      title: '로그아웃',
      content: '로그아웃을 진행할까요?',
      okText: '로그아웃',
      onConfirm: onLogout,
      isConfirming: isLoggingOut,
      isDanger: true, // Logout is a 'danger' action
      onCancel: () => Navigator.of(context).pop(),
    );
  }
}

// Helper function
Future<void> showLogoutModal({
  required BuildContext context,
  required VoidCallback onLogout,
}) {
  return showDialog(
    context: context,
    builder: (context) => LogoutModal(onLogout: onLogout),
  );
}
