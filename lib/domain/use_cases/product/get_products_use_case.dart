import 'package:we/core/error/result.dart';
import 'package:we/domain/entities/common/paginated_response_entity.dart';
import 'package:we/domain/entities/product/paginated_products_entity.dart';
import 'package:we/domain/entities/product/product_summary_entity.dart';
import 'package:we/domain/repositories/product/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  Future<Result<PaginatedProductsEntity>> call({
    int? page,
    int? limit,
    String? category,
    String? search,
  }) async {
    final result = await _repository.getProducts(
      page: page,
      limit: limit,
      category: category,
      search: search,
    );

    return result.when(
      success: (paginatedProducts) {
        final productSummaryEntities = paginatedProducts.items
            .map(
              (item) => ProductSummaryEntity(
                productId: item.productId,
                name: item.name,
                category: item.category,
                price: item.price,
                salePrice: item.salePrice,
                description: item.description,
                images: item.images,
                stock: item.stock,
                isAvailable: item.isAvailable,
                createdAt: item.createdAt,
              ),
            )
            .toList();

        final paginatedProductsEntity = PaginatedResponseEntity(
          totalCount: paginatedProducts.totalCount,
          currentPage: paginatedProducts.currentPage,
          totalPages: paginatedProducts.totalPages,
          items: productSummaryEntities,
          totalAmount: paginatedProducts.totalAmount,
        );

        return Result.success(paginatedProductsEntity);
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
