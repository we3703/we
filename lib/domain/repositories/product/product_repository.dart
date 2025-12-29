import 'package:we/core/api/error/result.dart';
import 'package:we/data/models/product/create_product_request.dart';
import 'package:we/data/models/product/delete_product_response.dart';
import 'package:we/data/models/product/paginated_products.dart';
import 'package:we/data/models/product/product_detail.dart';
import 'package:we/data/models/product/update_product_request.dart';
import 'package:we/data/models/product/update_product_response.dart';

/// Product Repository Interface
abstract class ProductRepository {
  /// Get paginated list of products
  Future<Result<PaginatedProducts>> getProducts({
    int? page,
    int? limit,
    String? category,
    String? search,
  });

  /// Get product detail by ID
  Future<Result<ProductDetail>> getProductDetail(String productId);

  /// Create a new product (Admin only)
  Future<Result<void>> createProduct(CreateProductRequest request);

  /// Update existing product (Admin only)
  Future<Result<UpdateProductResponse>> updateProduct(
    String productId,
    UpdateProductRequest request,
  );

  /// Delete product (Admin only)
  Future<Result<DeleteProductResponse>> deleteProduct(String productId);
}
