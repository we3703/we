class CreateProductRequest {
  final String name;
  final String category;
  final int price;
  final String description;
  final String detailDescription;
  final int stock;
  final bool isAvailable;
  final Map<String, dynamic> specifications;
  final List<String> images;

  CreateProductRequest({
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.detailDescription,
    required this.stock,
    required this.isAvailable,
    required this.specifications,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'description': description,
      'detail_description': detailDescription,
      'stock': stock,
      'is_available': isAvailable,
      'specifications': specifications,
      'images': images,
    };
  }
}
