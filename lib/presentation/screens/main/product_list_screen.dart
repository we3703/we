// product_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/domain/entities/product/paginated_products_entity.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/organisms/product/product_list.dart';
import 'package:we/presentation/screens/product/product_detail_screen.dart';
import 'package:we/presentation/screens/product/product_view_model.dart';

class ProductListScreen extends StatefulWidget {
  static const routeName = '/products';

  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().getProducts(
        page: _currentPage,
        limit: 10,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.layoutPadding),
          child:
              Selector<
                ProductViewModel,
                ({
                  bool isLoading,
                  String? errorMessage,
                  PaginatedProductsEntity? paginatedProducts,
                })
              >(
                selector: (_, vm) => (
                  isLoading: vm.isLoading,
                  errorMessage: vm.errorMessage,
                  paginatedProducts: vm.paginatedProducts,
                ),
                builder: (context, productState, child) {
                  if (productState.isLoading &&
                      productState.paginatedProducts == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (productState.errorMessage != null) {
                    return Center(
                      child: Text(
                        productState.errorMessage!,
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    );
                  }

                  final paginatedProducts = productState.paginatedProducts;
                  if (paginatedProducts == null ||
                      paginatedProducts.items.isEmpty) {
                    return Center(
                      child: Text(
                        '제품이 없습니다.',
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                    );
                  }

                  final products = paginatedProducts.items.map((product) {
                    return ProductListItemData(
                      imageUrl: product.images.isNotEmpty
                          ? product.images.first
                          : 'https://via.placeholder.com/400x300',
                      name: product.name,
                      description: product.description,
                      price: product.price,
                      salePrice: product.salePrice,
                      remaining: '${product.stock}개 남음',
                      onDetailsPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              productId: product.productId,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList();

                  return ProductList(
                    products: products,
                    currentPage: _currentPage,
                    totalPages: paginatedProducts.totalPages,
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage = page;
                      });
                      context.read<ProductViewModel>().getProducts(
                        page: page,
                        limit: 10,
                      );
                    },
                  );
                },
              ),
        ),
      ),
    );
  }
}
