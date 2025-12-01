import 'cart_item_entity.dart';

class CartEntity {
  final List<CartItemEntity> items;
  final int totalPrice;

  CartEntity({required this.items, required this.totalPrice});
}
