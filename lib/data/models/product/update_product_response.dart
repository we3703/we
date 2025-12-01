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
      productId: json['productId'],
      name: json['name'],
      price: json['price'],
      stock: json['stock'],
      isAvailable: json['isAvailable'],
      updatedAt: json['updatedAt'],
    );
  }
}
