class ProductInfo {
  final String productId;
  final String name;
  final String image;
  final int? price;

  ProductInfo({
    required this.productId,
    required this.name,
    required this.image,
    this.price,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      productId: (json['productId'] ?? json['product_id'])?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: json['price'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'image': image,
      if (price != null) 'price': price,
    };
  }
}
