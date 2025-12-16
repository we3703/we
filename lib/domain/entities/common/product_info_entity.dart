class ProductInfoEntity {
  final String productId;
  final String name;
  final String image;
  final int? price;
  final int? salePrice;

  ProductInfoEntity({
    required this.productId,
    required this.name,
    required this.image,
    this.price,
    this.salePrice,
  });
}
