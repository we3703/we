import 'package:flutter/material.dart';
import 'package:we/data/models/order/paginated_orders.dart';
import 'package:we/domain/use_cases/order/get_my_orders_use_case.dart';

class OrderViewModel extends ChangeNotifier {
  final GetMyOrdersUseCase _getMyOrdersUseCase;

  OrderViewModel(this._getMyOrdersUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PaginatedOrders? _paginatedOrders;
  PaginatedOrders? get paginatedOrders => _paginatedOrders;

  Future<void> getMyOrders({int page = 1, int limit = 10}) async {
    _isLoading = true;
    notifyListeners();

    final result = await _getMyOrdersUseCase(page: page, limit: limit);

    result.when(
      success: (orders) {
        _paginatedOrders = orders;
        _isLoading = false;
        notifyListeners();
      },
      failure: (failure) {
        _isLoading = false;
        _errorMessage = failure.message;
        notifyListeners();
      },
    );
  }
}
