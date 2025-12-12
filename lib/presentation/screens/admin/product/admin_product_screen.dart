import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/domain/entities/product/product_summary_entity.dart';
import 'package:we/presentation/atoms/buttons/danger_button.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/atoms/buttons/secondary_button.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
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
              SecondaryButton(text: '취소', onPressed: () => Navigator.pop(context)),
              DangerButton(
                text: '삭제',
                onPressed: () {
                  context.read<AdminProductViewModel>().deleteProduct(productId);
                  Navigator.pop(context);
                },
              ),
            ],
          )
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
                        return Card(
                          margin: const EdgeInsets.only(
                            bottom: AppSpacing.space12,
                          ),
                          child: ListTile(
                            leading: product.images.isNotEmpty
                                ? Image.network(
                                    product.images.first,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 60,
                                        height: 60,
                                        color: AppColors.subSurface,
                                        child: const Icon(
                                          Icons.image_not_supported,
                                          color: AppColors.textDisabled,
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    width: 60,
                                    height: 60,
                                    color: AppColors.subSurface,
                                    child: const Icon(
                                      Icons.shopping_bag,
                                      color: AppColors.textDisabled,
                                    ),
                                  ),
                            title: Text(
                              product.name,
                              style: AppTextStyles.bodyBold,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: AppSpacing.space8),
                                Text(
                                  '${product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                  style: AppTextStyles.subMedium.copyWith(
                                    color: AppColors.primaryGreen,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '재고: ${product.stock}개 | ${product.isAvailable ? '판매중' : '판매중지'}',
                                  style: AppTextStyles.subRegular.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.textPrimary,
                                  ),
                                  onPressed: () =>
                                      _navigateToProductForm(product: product),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.error,
                                  ),
                                  onPressed: () => _showDeleteConfirmDialog(
                                    product.productId,
                                  ),
                                ),
                              ],
                            ),
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
