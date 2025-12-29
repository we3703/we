import 'package:we/data/models/cart/cart.dart';

import 'package:we/core/api/error/result.dart';
import 'package:we/data/models/cart/add_cart_item_request.dart';
import 'package:we/data/models/cart/update_cart_item_request.dart';

/// Cart Repository Interface
abstract class CartRepository {
  /// Add item to cart
  Future<Result<void>> addCartItem(AddCartItemRequest request);

  /// Get cart items
  Future<Result<Cart>> getCart();

  /// Update cart item quantity
  Future<Result<void>> updateCartItem(
    String itemId,
    UpdateCartItemRequest request,
  );

  /// Delete cart item
  Future<Result<void>> deleteCartItem(String itemId);
}
