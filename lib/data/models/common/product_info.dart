class ProductInfo {
  final String productId;
  final String name;
  final String image;
  final int? price;
  final int? salePrice;

  ProductInfo({
    required this.productId,
    required this.name,
    required this.image,
    this.price,
    this.salePrice,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      productId: (json['product_id'] ?? json['productId'])?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: json['price'] as int?,
      salePrice: json['sale_price'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'image': image,
      if (price != null) 'price': price,
      if (salePrice != null) 'sale_price': salePrice,
    };
  }
}
