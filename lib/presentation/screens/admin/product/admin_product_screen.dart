import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/domain/entities/product/product_summary_entity.dart';
import 'package:we/presentation/atoms/buttons/danger_button.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/atoms/buttons/secondary_button.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/cards/product/product_card.dart';
import 'package:we/presentation/screens/admin/product/admin_product_form_screen.dart';
import 'package:we/presentation/screens/admin/product/admin_product_view_model.dart';

class AdminProductScreen extends StatefulWidget {
  const AdminProductScreen({super.key});

  @override
  State<AdminProductScreen> createState() => _AdminProductScreenState();
}

class _AdminProductScreenState extends State<AdminProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProductViewModel>().getProducts();
    });
  }

  void _navigateToProductForm({ProductSummaryEntity? product}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminProductFormScreen(product: product),
      ),
    );
  }

  void _showDeleteConfirmDialog(String productId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('삭제 확인', style: AppTextStyles.heading3Bold),
        content: Text('정말로 이 제품을 삭제하시겠습니까?', style: AppTextStyles.bodyRegular),
        actions: [
          Row(
            children: [
              SecondaryButton(
                text: '취소',
                onPressed: () => Navigator.pop(context),
              ),
              DangerButton(
                text: '삭제',
                onPressed: () {
                  context.read<AdminProductViewModel>().deleteProduct(
                    productId,
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProductViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  viewModel.errorMessage!,
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: AppSpacing.space20),
                PrimaryButton(
                  text: '다시 시도',
                  onPressed: () => viewModel.getProducts(),
                ),
              ],
            ),
          );
        }

        final products = viewModel.paginatedProducts?.items ?? [];

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.layoutPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '총 ${viewModel.paginatedProducts?.totalCount ?? 0}개',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  PrimaryButton(
                    text: '새 제품',
                    onPressed: () => _navigateToProductForm(),
                    icon: Icons.add,
                  ),
                ],
              ),
            ),
            Expanded(
              child: products.isEmpty
                  ? Center(
                      child: Text(
                        '제품이 없습니다',
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.layoutPadding,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.space12,
                          ),
                          child: ProductCard(
                            imageUrl: product.images.isNotEmpty
                                ? product.images.first
                                : 'https://via.placeholder.com/150',
                            productName: product.name,
                            productDescription:
                                '재고: ${product.stock}개 | ${product.isAvailable ? '판매중' : '판매중지'}',
                            price: product.price,
                            salePrice: product.salePrice,
                            quantityRemaining: '${product.stock}개 남음',
                            onEditPressed: () =>
                                _navigateToProductForm(product: product),
                            onDeletePressed: () =>
                                _showDeleteConfirmDialog(product.productId),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
