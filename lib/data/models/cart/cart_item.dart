class CartItem {
  final String productId;
  final String name;
  final int quantity;
  final int price;
  final String imageUrl;

  CartItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: (json['productId'] ?? json['product_id'])?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      quantity: json['quantity'] as int? ?? 0,
      price: json['price'] as int? ?? 0,
      imageUrl: (json['imageUrl'] ?? json['image_url'])?.toString() ?? '',
    );
  }
}
