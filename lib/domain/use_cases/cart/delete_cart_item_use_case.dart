import 'package:we/core/error/result.dart';
import 'package:we/domain/repositories/cart/cart_repository.dart';

class DeleteCartItemUseCase {
  final CartRepository _repository;

  DeleteCartItemUseCase(this._repository);

  Future<Result<void>> call(String itemId) {
    return _repository.deleteCartItem(itemId);
  }
}
