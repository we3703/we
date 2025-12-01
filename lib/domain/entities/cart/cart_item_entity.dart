class CartItemEntity {
  final String productId;
  final String name;
  final int quantity;
  final int price;
  final String imageUrl;

  CartItemEntity({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}
