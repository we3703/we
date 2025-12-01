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
      productId: json['productId'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
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
