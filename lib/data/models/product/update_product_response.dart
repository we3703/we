class UpdateProductResponse {
  final String productId;
  final String name;
  final int price;
  final int stock;
  final bool isAvailable;
  final String updatedAt;

  UpdateProductResponse({
    required this.productId,
    required this.name,
    required this.price,
    required this.stock,
    required this.isAvailable,
    required this.updatedAt,
  });

  factory UpdateProductResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProductResponse(
      productId: (json['productId'] ?? json['product_id'])?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: json['price'] as int? ?? 0,
      stock: json['stock'] as int? ?? 0,
      isAvailable: (json['isAvailable'] ?? json['is_available']) as bool? ?? false,
      updatedAt: (json['updatedAt'] ?? json['updated_at'])?.toString() ?? '',
    );
  }
}
