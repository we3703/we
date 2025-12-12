import 'package:we/data/models/cart/cart_item.dart';

class Cart {
  final List<CartItem> items;
  final int totalPrice;

  Cart({required this.items, required this.totalPrice});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      items: (json['items'] as List? ?? [])
          .map((itemJson) => CartItem.fromJson(itemJson as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] ?? json['total_price']) as int? ?? 0,
    );
  }
}
