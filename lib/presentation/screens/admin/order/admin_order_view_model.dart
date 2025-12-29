import 'package:flutter/material.dart';
import 'package:we/core/api/error/failure.dart';
import 'package:we/domain/entities/admin/order/paginated_admin_orders_entity.dart';
import 'package:we/domain/use_cases/admin/order/get_admin_orders_use_case.dart';

class AdminOrderViewModel extends ChangeNotifier {
  final GetAdminOrdersUseCase _getAdminOrdersUseCase;

  AdminOrderViewModel(this._getAdminOrdersUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PaginatedAdminOrdersEntity? _paginatedAdminOrders;
  PaginatedAdminOrdersEntity? get paginatedAdminOrders => _paginatedAdminOrders;

  Future<void> getAdminOrders() async {
    _isLoading = true;
    notifyListeners();

    final result = await _getAdminOrdersUseCase();

    result.when(
      success: (data) {
        _paginatedAdminOrders = data;
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _paginatedAdminOrders = null;
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
