import 'package:we/core/error/result.dart';
import 'package:we/data/models/cart/update_cart_item_request.dart';
import 'package:we/domain/repositories/cart/cart_repository.dart';

class UpdateCartItemUseCase {
  final CartRepository _repository;

  UpdateCartItemUseCase(this._repository);

  Future<Result<void>> call(String itemId, UpdateCartItemRequest request) {
    return _repository.updateCartItem(itemId, request);
  }
}
