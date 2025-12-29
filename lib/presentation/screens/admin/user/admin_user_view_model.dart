import 'package:flutter/material.dart';
import 'package:we/core/api/error/failure.dart';
import 'package:we/domain/entities/admin/user/paginated_admin_users_entity.dart';
import 'package:we/domain/use_cases/admin/user/get_admin_users_use_case.dart';

class AdminUserViewModel extends ChangeNotifier {
  final GetAdminUsersUseCase _getAdminUsersUseCase;

  AdminUserViewModel(this._getAdminUsersUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PaginatedAdminUsersEntity? _paginatedAdminUsers;
  PaginatedAdminUsersEntity? get paginatedAdminUsers => _paginatedAdminUsers;

  Future<void> getAdminUsers() async {
    _isLoading = true;
    notifyListeners();

    final result = await _getAdminUsersUseCase();

    result.when(
      success: (data) {
        _paginatedAdminUsers = data;
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _paginatedAdminUsers = null;
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
