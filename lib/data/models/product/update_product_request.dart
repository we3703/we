class UpdateProductRequest {
  final String? name;
  final int? price;
  final int? salePrice;
  final int? stock;
  final bool? isAvailable;

  UpdateProductRequest({this.name, this.price, this.salePrice, this.stock, this.isAvailable});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (price != null) data['price'] = price;
    if (salePrice != null) data['sale_price'] = salePrice;
    if (stock != null) data['stock'] = stock;
    if (isAvailable != null) data['isAvailable'] = isAvailable;
    return data;
  }
}
