import 'package:we/data/models/product/update_product_request.dart';

import 'package:we/core/error/result.dart';
import 'package:we/domain/entities/product/update_product_response_entity.dart';
import 'package:we/domain/repositories/product/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository _repository;

  UpdateProductUseCase(this._repository);

  Future<Result<UpdateProductResponseEntity>> call(
    String productId,
    UpdateProductRequest request,
  ) async {
    final result = await _repository.updateProduct(productId, request);
    return result.when(
      success: (response) {
        return Result.success(
          UpdateProductResponseEntity(
            productId: response.productId,
            name: response.name,
            price: response.price,
            stock: response.stock,
            isAvailable: response.isAvailable,
            updatedAt: response.updatedAt,
          ),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
