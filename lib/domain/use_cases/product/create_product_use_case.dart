import 'package:we/data/models/product/create_product_request.dart';

import 'package:we/core/error/result.dart';
import 'package:we/domain/repositories/product/product_repository.dart';

class CreateProductUseCase {
  final ProductRepository _repository;

  CreateProductUseCase(this._repository);

  Future<Result<void>> call(CreateProductRequest request) {
    return _repository.createProduct(request);
  }
}
