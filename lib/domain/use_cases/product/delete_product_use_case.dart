import 'package:we/core/error/result.dart';
import 'package:we/domain/entities/product/delete_product_response_entity.dart';
import 'package:we/domain/repositories/product/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository _repository;

  DeleteProductUseCase(this._repository);

  Future<Result<DeleteProductResponseEntity>> call(String productId) async {
    final result = await _repository.deleteProduct(productId);
    return result.when(
      success: (response) {
        return Result.success(
          DeleteProductResponseEntity(
            id: response.id,
            deletedAt: response.deletedAt,
          ),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
