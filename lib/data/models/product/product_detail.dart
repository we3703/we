class ProductDetail {
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

  ProductDetail({
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

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      productId: (json['id'] ?? json['productId'] ?? json['product_id'])?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      price: json['price'] as int? ?? 0,
      description: json['description']?.toString() ?? '',
      detailDescription: (json['detail_description'] ?? json['detailDescription'])?.toString() ?? '',
      images: List<String>.from(json['images'] ?? []),
      stock: json['stock'] as int? ?? 0,
      isAvailable: (json['is_available'] ?? json['isAvailable']) as bool? ?? true,
      specifications: Map<String, dynamic>.from(json['specifications'] ?? {}),
      reviewCount: (json['review_count'] ?? json['reviewCount']) as int? ?? 0,
      averageRating: ((json['average_rating'] ?? json['averageRating']) as num?)?.toDouble() ?? 0.0,
      createdAt: (json['created_at'] ?? json['createdAt'])?.toString() ?? '',
    );
  }
}
