import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:we/presentation/molecules/indicator/toast_message.dart';

class ToastService {
  /// Show a custom toast with ToastMessage widget
  static void showToast(
    String message, {
    Duration autoCloseDuration = const Duration(seconds: 3),
    Alignment alignment = Alignment.bottomCenter,
  }) {
    toastification.showCustom(
      alignment: alignment,
      autoCloseDuration: autoCloseDuration,
      builder: (BuildContext context, ToastificationItem holder) {
        return ToastMessage(message: message);
      },
    );
  }

  /// Convenience method for success messages
  static void showSuccess(String message) => showToast(message);

  /// Convenience method for error messages
  static void showError(String message) => showToast(message);

  /// Convenience method for info messages
  static void showInfo(String message) => showToast(message);

  // Private constructor
  ToastService._();
}
