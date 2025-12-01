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
      productId: json['productId'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      description: json['description'],
      detailDescription: json['detailDescription'],
      images: List<String>.from(json['images']),
      stock: json['stock'],
      isAvailable: json['isAvailable'],
      specifications: Map<String, dynamic>.from(json['specifications']),
      reviewCount: json['reviewCount'],
      averageRating: (json['averageRating'] as num).toDouble(),
      createdAt: json['createdAt'],
    );
  }
}
