import 'package:we/data/models/product/create_product_request.dart';
import 'package:we/data/models/product/update_product_request.dart';
import 'package:we/domain/entities/product/delete_product_response_entity.dart';
import 'package:we/domain/entities/product/paginated_products_entity.dart';
import 'package:we/domain/entities/product/product_detail_entity.dart';
import 'package:we/domain/entities/product/update_product_response_entity.dart';
import 'package:we/domain/use_cases/product/create_product_use_case.dart';
import 'package:we/domain/use_cases/product/delete_product_use_case.dart';
import 'package:we/domain/use_cases/product/get_product_detail_use_case.dart';
import 'package:we/domain/use_cases/product/get_products_use_case.dart';
import 'package:we/domain/use_cases/product/update_product_use_case.dart';
import 'package:we/presentation/base/base_view_model.dart';

class ProductViewModel extends BaseViewModel {
  final GetProductsUseCase _getProductsUseCase;
  final GetProductDetailUseCase _getProductDetailUseCase;
  final CreateProductUseCase _createProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;

  ProductViewModel(
    this._getProductsUseCase,
    this._getProductDetailUseCase,
    this._createProductUseCase,
    this._updateProductUseCase,
    this._deleteProductUseCase,
  );

  PaginatedProductsEntity? _paginatedProducts;
  PaginatedProductsEntity? get paginatedProducts => _paginatedProducts;

  ProductDetailEntity? _productDetail;
  ProductDetailEntity? get productDetail => _productDetail;

  UpdateProductResponseEntity? _updatedProduct;
  UpdateProductResponseEntity? get updatedProduct => _updatedProduct;

  DeleteProductResponseEntity? _deletedProduct;
  DeleteProductResponseEntity? get deletedProduct => _deletedProduct;

  Future<void> getProducts({
    int? page,
    int? limit,
    String? category,
    String? search,
  }) async {
    setLoading(true);
    clearError();

    final result = await _getProductsUseCase(
      page: page,
      limit: limit,
      category: category,
      search: search,
    );

    result.when(
      success: (data) {
        _paginatedProducts = data;
        setError(null);
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
        _paginatedProducts = null;
      },
    );

    setLoading(false);
  }

  Future<void> getProductDetail(String productId) async {
    setLoading(true);
    clearError();

    final result = await _getProductDetailUseCase(productId);

    result.when(
      success: (data) {
        _productDetail = data;
        setError(null);
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
        _productDetail = null;
      },
    );

    setLoading(false);
  }

  Future<void> createProduct(CreateProductRequest request) async {
    setLoading(true);
    clearError();

    final result = await _createProductUseCase(request);

    result.when(
      success: (_) {
        setError(null);
        getProducts();
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
      },
    );

    setLoading(false);
  }

  Future<void> updateProduct(
    String productId,
    UpdateProductRequest request,
  ) async {
    setLoading(true);
    clearError();

    final result = await _updateProductUseCase(productId, request);

    result.when(
      success: (data) {
        _updatedProduct = data;
        setError(null);
        getProductDetail(productId);
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
        _updatedProduct = null;
      },
    );

    setLoading(false);
  }

  Future<void> deleteProduct(String productId) async {
    setLoading(true);
    clearError();

    final result = await _deleteProductUseCase(productId);

    result.when(
      success: (data) {
        _deletedProduct = data;
        setError(null);
        getProducts();
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
        _deletedProduct = null;
      },
    );

    setLoading(false);
  }

  /// Calculate points after purchase
  String calculatePointsAfterPurchase(int currentPoints, int productPrice) {
    final remainingPoints = currentPoints - productPrice;
    return '$remainingPoints P';
  }
}
