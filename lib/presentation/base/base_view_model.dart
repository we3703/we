import 'package:flutter/material.dart';
import 'package:we/core/error/failure.dart';

/// Base ViewModel class with common functionality
abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Set loading state and notify listeners
  void setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  /// Set error message and notify listeners
  void setError(String? error) {
    if (_errorMessage != error) {
      _errorMessage = error;
      notifyListeners();
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Map Failure to user-friendly error message
  String mapFailureToMessage(Failure failure) {
    // Can be overridden by subclasses for specific error handling
    return failure.message;
  }
}
