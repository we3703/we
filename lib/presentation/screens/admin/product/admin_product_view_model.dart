import 'package:flutter/material.dart';
import 'package:we/core/error/failure.dart';
import 'package:we/core/utils/toast_service.dart';
import 'package:we/data/models/product/create_product_request.dart';
import 'package:we/data/models/product/update_product_request.dart';
import 'package:we/domain/entities/product/paginated_products_entity.dart';
import 'package:we/domain/use_cases/product/create_product_use_case.dart';
import 'package:we/domain/use_cases/product/delete_product_use_case.dart';
import 'package:we/domain/use_cases/product/get_products_use_case.dart';
import 'package:we/domain/use_cases/product/update_product_use_case.dart';

class AdminProductViewModel extends ChangeNotifier {
  final GetProductsUseCase _getProductsUseCase;
  final CreateProductUseCase _createProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;

  AdminProductViewModel(
    this._getProductsUseCase,
    this._createProductUseCase,
    this._updateProductUseCase,
    this._deleteProductUseCase,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PaginatedProductsEntity? _paginatedProducts;
  PaginatedProductsEntity? get paginatedProducts => _paginatedProducts;

  Future<void> getProducts() async {
    _isLoading = true;
    notifyListeners();

    final result = await _getProductsUseCase();

    result.when(
      success: (data) {
        _paginatedProducts = data;
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _paginatedProducts = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createProduct(CreateProductRequest request) async {
    final result = await _createProductUseCase(request);

    result.when(
      success: (_) {
        ToastService.showSuccess('제품이 생성되었습니다');
        getProducts();
      },
      failure: (failure) {
        ToastService.showError(_mapFailureToMessage(failure));
      },
    );
  }

  Future<void> updateProduct(
    String productId,
    UpdateProductRequest request,
  ) async {
    final result = await _updateProductUseCase(productId, request);

    result.when(
      success: (_) {
        ToastService.showSuccess('제품이 수정되었습니다');
        getProducts();
      },
      failure: (failure) {
        ToastService.showError(_mapFailureToMessage(failure));
      },
    );
  }

  Future<void> deleteProduct(String productId) async {
    final result = await _deleteProductUseCase(productId);

    result.when(
      success: (_) {
        ToastService.showSuccess('제품이 삭제되었습니다');
        getProducts();
      },
      failure: (failure) {
        ToastService.showError(_mapFailureToMessage(failure));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
