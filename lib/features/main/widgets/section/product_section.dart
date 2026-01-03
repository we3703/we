import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/widgets/card/product_card.dart';
import 'package:we/domain/entities/product/paginated_products_entity.dart';
import 'package:we/features/main/screen/main_scaffold.dart';
import 'package:we/features/main/widgets/section_header.dart';
import 'package:we/presentation/screens/product/product_detail_screen.dart';
import 'package:we/presentation/screens/product/product_view_model.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: '신규 제품', onMoreTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MainScaffold(initialIndex: 1),
            ),
          );
        }),
        const SizedBox(height: AppSpacing.space24),
        Selector<ProductViewModel, ({bool isLoading, PaginatedProductsEntity? products})>(
          selector: (_, vm) => (isLoading: vm.isLoading, products: vm.paginatedProducts),
          builder: (context, state, child) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.products == null || state.products!.items.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.layoutPadding),
                child: Text('제품이 없습니다.'),
              );
            }

            final items = state.products!.items.take(4).toList();

            return SizedBox(
              height: 215,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final product = items[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? AppSpacing.layoutPadding : 0,
                      right: 12,
                    ),
                    child: SizedBox(
                      width: 160,
                      child: ProductCard(
                        imageUrl: product.images.isNotEmpty ? product.images.first : null,
                        title: product.name,
                        description: product.description,
                        originalPrice: product.price,
                        price: product.salePrice,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                productId: product.productId,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
