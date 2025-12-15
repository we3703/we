// product_list.dart
import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/cards/product/product_card.dart';
import 'package:we/presentation/molecules/indicator/page_indicator.dart';

class ProductListItemData {
  final String imageUrl;
  final String name;
  final String description;
  final int price;
  final String remaining;
  final VoidCallback? onDetailsPressed;

  ProductListItemData({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.remaining,
    this.onDetailsPressed,
  });
}

class ProductList extends StatelessWidget {
  final List<ProductListItemData> products;
  final int currentPage;
  final int totalPages;
  final Function(int page) onPageChanged;

  const ProductList({
    super.key,
    required this.products,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final showPagination = totalPages > 1;
    final itemCount = products.length + (showPagination ? 1 : 0);

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index < products.length) {
          final product = products[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < products.length - 1 ? AppSpacing.space12 : 0,
            ),
            child: ProductCard(
              imageUrl: product.imageUrl,
              productName: product.name,
              productDescription: product.description,
              price: product.price,
              onDetailsPressed: product.onDetailsPressed,
              quantityRemaining: product.remaining,
              showQuantityRemaining: true,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: AppSpacing.space32),
            child: PageIndicator(
              currentPage: currentPage,
              totalPages: totalPages,
              onPageChanged: onPageChanged,
            ),
          );
        }
      },
    );
  }
}
