class ProductInfoEntity {
  final String productId;
  final String name;
  final String image;
  final int? price;

  ProductInfoEntity({
    required this.productId,
    required this.name,
    required this.image,
    this.price,
  });
}
