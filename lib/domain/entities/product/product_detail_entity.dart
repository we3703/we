class ProductDetailEntity {
  final String productId;
  final String name;
  final String category;
  final int price;
  final String description;
  final String detailDescription;
  final List<String> images;
  final int stock;
  final bool isAvailable;
  final Map<String, dynamic> specifications;
  final int reviewCount;
  final double averageRating;
  final String createdAt;

  ProductDetailEntity({
    required this.productId,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.detailDescription,
    required this.images,
    required this.stock,
    required this.isAvailable,
    required this.specifications,
    required this.reviewCount,
    required this.averageRating,
    required this.createdAt,
  });
}
