import 'package:we/data/models/common/paginated_response.dart';

class ProductSummary {
  final String productId;
  final String name;
  final String category;
  final int price;
  final String description;
  final List<String> images;
  final int stock;
  final bool isAvailable;
  final String createdAt;

  ProductSummary({
    required this.productId,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.images,
    required this.stock,
    required this.isAvailable,
    required this.createdAt,
  });

  factory ProductSummary.fromJson(Map<String, dynamic> json) {
    return ProductSummary(
      productId: (json['product_id'] ?? json['productId'])?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      price: json['price'] as int? ?? 0,
      description: json['description']?.toString() ?? '',
      images: List<String>.from(json['images'] ?? []),
      stock: json['stock'] as int? ?? 0,
      isAvailable:
          (json['is_available'] ?? json['isAvailable']) as bool? ?? true,
      createdAt: (json['created_at'] ?? json['createdAt'])?.toString() ?? '',
    );
  }
}

typedef PaginatedProducts = PaginatedResponse<ProductSummary>;

extension PaginatedProductsExtension on PaginatedProducts {
  static PaginatedProducts fromJson(Map<String, dynamic> json) {
    return PaginatedResponse.fromJson(
      json,
      'products',
      ProductSummary.fromJson,
    );
  }

  List<ProductSummary> get products => items;
}
