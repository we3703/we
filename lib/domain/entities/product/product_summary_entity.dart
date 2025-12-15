class ProductSummaryEntity {
  final String productId;
  final String name;
  final String category;
  final int price;
  final int salePrice;
  final String description;
  final List<String> images;
  final int stock;
  final bool isAvailable;
  final String createdAt;

  ProductSummaryEntity({
    required this.productId,
    required this.name,
    required this.category,
    required this.price,
    required this.salePrice,
    required this.description,
    required this.images,
    required this.stock,
    required this.isAvailable,
    required this.createdAt,
  });
}
