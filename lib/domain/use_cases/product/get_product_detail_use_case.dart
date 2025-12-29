import 'package:we/core/api/error/result.dart';
import 'package:we/domain/entities/product/product_detail_entity.dart';
import 'package:we/domain/repositories/product/product_repository.dart';

class GetProductDetailUseCase {
  final ProductRepository _repository;

  GetProductDetailUseCase(this._repository);

  Future<Result<ProductDetailEntity>> call(String productId) async {
    final result = await _repository.getProductDetail(productId);
    return result.when(
      success: (productDetail) {
        return Result.success(
          ProductDetailEntity(
            productId: productDetail.productId,
            name: productDetail.name,
            category: productDetail.category,
            price: productDetail.price,
            salePrice: productDetail.salePrice,
            description: productDetail.description,
            detailDescription: productDetail.detailDescription,
            images: productDetail.images,
            stock: productDetail.stock,
            isAvailable: productDetail.isAvailable,
            specifications: productDetail.specifications,
            reviewCount: productDetail.reviewCount,
            averageRating: productDetail.averageRating,
            createdAt: productDetail.createdAt,
          ),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
