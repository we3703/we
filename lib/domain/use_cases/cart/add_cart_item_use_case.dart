import 'package:we/core/api/error/result.dart';
import 'package:we/data/models/cart/add_cart_item_request.dart';
import 'package:we/domain/repositories/cart/cart_repository.dart';

class AddCartItemUseCase {
  final CartRepository _repository;

  AddCartItemUseCase(this._repository);

  Future<Result<void>> call(AddCartItemRequest request) {
    return _repository.addCartItem(request);
  }
}
