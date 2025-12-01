import 'package:flutter/material.dart';
import 'package:we/core/error/failure.dart';
import 'package:we/data/models/cart/add_cart_item_request.dart';
import 'package:we/data/models/cart/update_cart_item_request.dart';
import 'package:we/domain/entities/cart/cart_entity.dart';
import 'package:we/domain/use_cases/cart/add_cart_item_use_case.dart';
import 'package:we/domain/use_cases/cart/delete_cart_item_use_case.dart';
import 'package:we/domain/use_cases/cart/get_cart_use_case.dart';
import 'package:we/domain/use_cases/cart/update_cart_item_use_case.dart';

class CartViewModel extends ChangeNotifier {
  final AddCartItemUseCase _addCartItemUseCase;
  final GetCartUseCase _getCartUseCase;
  final UpdateCartItemUseCase _updateCartItemUseCase;
  final DeleteCartItemUseCase _deleteCartItemUseCase;

  CartViewModel(
    this._addCartItemUseCase,
    this._getCartUseCase,
    this._updateCartItemUseCase,
    this._deleteCartItemUseCase,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CartEntity? _cart;
  CartEntity? get cart => _cart;

  Future<void> addCartItem(AddCartItemRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _addCartItemUseCase(request);

    result.when(
      success: (_) {
        _errorMessage = null;
        // Optionally, refresh cart after adding item
        getCart();
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getCart() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _getCartUseCase();

    result.when(
      success: (cartEntity) {
        _cart = cartEntity;
        _errorMessage = null;
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _cart = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateCartItem(
    String itemId,
    UpdateCartItemRequest request,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _updateCartItemUseCase(itemId, request);

    result.when(
      success: (_) {
        _errorMessage = null;
        // Optionally, refresh cart after updating item
        getCart();
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteCartItem(String itemId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _deleteCartItemUseCase(itemId);

    result.when(
      success: (_) {
        _errorMessage = null;
        // Optionally, refresh cart after deleting item
        getCart();
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
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
