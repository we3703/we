import 'package:we/core/api/error/result.dart';
import 'package:we/domain/entities/cart/cart_entity.dart';
import 'package:we/domain/entities/cart/cart_item_entity.dart';
import 'package:we/domain/repositories/cart/cart_repository.dart';

class GetCartUseCase {
  final CartRepository _repository;

  GetCartUseCase(this._repository);

  Future<Result<CartEntity>> call() async {
    final result = await _repository.getCart();
    return result.when(
      success: (cart) {
        final items = cart.items
            .map(
              (item) => CartItemEntity(
                productId: item.productId,
                name: item.name,
                quantity: item.quantity,
                price: item.price,
                imageUrl: item.imageUrl,
              ),
            )
            .toList();
        return Result.success(
          CartEntity(items: items, totalPrice: cart.totalPrice),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
