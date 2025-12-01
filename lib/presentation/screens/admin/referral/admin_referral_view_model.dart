import 'package:flutter/material.dart';
import 'package:we/core/error/failure.dart';
import 'package:we/domain/entities/admin/referral/admin_referral_node_entity.dart';
import 'package:we/domain/use_cases/admin/referral/get_admin_user_referral_tree_use_case.dart';

class AdminReferralViewModel extends ChangeNotifier {
  final GetAdminUserReferralTreeUseCase _getAdminUserReferralTreeUseCase;

  AdminReferralViewModel(this._getAdminUserReferralTreeUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AdminReferralNodeEntity? _adminReferralTree;
  AdminReferralNodeEntity? get adminReferralTree => _adminReferralTree;

  Future<void> getAdminUserReferralTree(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _getAdminUserReferralTreeUseCase(userId);

    result.when(
      success: (data) {
        _adminReferralTree = data;
        _errorMessage = null;
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _adminReferralTree = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  String _mapFailureToMessage(Failure failure) {
    // Implement more specific error mapping based on your Failure types
    return failure.message;
  }
}
