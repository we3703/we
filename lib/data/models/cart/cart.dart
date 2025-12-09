import 'package:we/data/models/cart/cart_item.dart';

class Cart {
  final List<CartItem> items;
  final int totalPrice;

  Cart({required this.items, required this.totalPrice});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      items: (json['items'] as List? ?? [])
          .map((itemJson) => CartItem.fromJson(itemJson))
          .toList(),
      totalPrice: json['totalPrice'],
    );
  }
}
