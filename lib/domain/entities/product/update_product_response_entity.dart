class UpdateProductResponseEntity {
  final String productId;
  final String name;
  final int price;
  final int stock;
  final bool isAvailable;
  final String updatedAt;

  UpdateProductResponseEntity({
    required this.productId,
    required this.name,
    required this.price,
    required this.stock,
    required this.isAvailable,
    required this.updatedAt,
  });
}
