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
      productId: (json['productId'] ?? json['product_id'])?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      price: json['price'] as int? ?? 0,
      description: json['description']?.toString() ?? '',
      detailDescription: (json['detailDescription'] ?? json['detail_description'])?.toString() ?? '',
      images: List<String>.from(json['images'] ?? []),
      stock: json['stock'] as int? ?? 0,
      isAvailable: (json['isAvailable'] ?? json['is_available']) as bool? ?? true,
      specifications: Map<String, dynamic>.from(json['specifications'] ?? {}),
      reviewCount: (json['reviewCount'] ?? json['review_count']) as int? ?? 0,
      averageRating: ((json['averageRating'] ?? json['average_rating']) as num?)?.toDouble() ?? 0.0,
      createdAt: (json['createdAt'] ?? json['created_at'])?.toString() ?? '',
    );
  }
}
