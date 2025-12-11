import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/utils/toast_service.dart';
import 'package:we/domain/use_cases/order/create_order_use_case.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/molecules/cards/product/product_detail_card.dart';
import 'package:we/presentation/molecules/image/image_carousel.dart';
import 'package:we/presentation/molecules/modal/purchase_confirm_modal.dart';
import 'package:we/presentation/screens/product/product_view_model.dart';
import 'package:we/presentation/screens/user/user_view_model.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/productDetail';

  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().getProductDetail(widget.productId);
      context.read<UserViewModel>().getMe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: '제품 상세', showBackButton: true),
      body: SafeArea(
        child: Consumer2<ProductViewModel, UserViewModel>(
          builder: (context, productVM, userVM, child) {
            if (productVM.isLoading && productVM.productDetail == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (productVM.errorMessage != null) {
              return Center(child: Text(productVM.errorMessage!));
            }

            final productDetail = productVM.productDetail;
            if (productDetail == null) {
              return const Center(child: Text('제품 정보를 불러올 수 없습니다.'));
            }

            // Parse specifications into DetailSections
            final List<DetailSection> detailSections = [];

            // Add specifications if available
            if (productDetail.specifications.isNotEmpty) {
              productDetail.specifications.forEach((key, value) {
                if (value is List) {
                  detailSections.add(
                    DetailSection(title: key, items: List<String>.from(value)),
                  );
                } else if (value is String) {
                  detailSections.add(DetailSection(title: key, items: [value]));
                }
              });
            }

            final myInfo = userVM.myInfo;
            final pointsAfterPurchase = myInfo != null
                ? '${myInfo.points - productDetail.price} P'
                : '0 P';

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageCarousel(
                          imageUrls: productDetail.images.isNotEmpty
                              ? productDetail.images
                              : ['https://via.placeholder.com/600x400'],
                          height: 250,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                            AppSpacing.layoutPadding,
                          ),
                          child: ProductDetailCard(
                            category: productDetail.category,
                            title: productDetail.name,
                            price: '${productDetail.price} P',
                            remaining: '${productDetail.stock}개 남음',
                            sections: detailSections,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.layoutPadding),
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      text: '구매하기',
                      onPressed:
                          productDetail.isAvailable && productDetail.stock > 0
                          ? () {
                              showPurchaseConfirmModal(
                                context: context,
                                productName: productDetail.name,
                                price: '${productDetail.price} P',
                                pointsAfterPurchase: pointsAfterPurchase,
                                onConfirm: () async {
                                  final createOrderUseCase = context
                                      .read<CreateOrderUseCase>();

                                  final orderData = {
                                    'product_id': productDetail.productId,
                                    'quantity': 1,
                                  };

                                  final result = await createOrderUseCase(
                                    orderData,
                                  );

                                  result.when(
                                    success: (_) {
                                      if (context.mounted) {
                                        // Refresh user info to update points
                                        context.read<UserViewModel>().getMe();

                                        ToastService.showSuccess(
                                          '구매가 완료되었습니다!',
                                        );
                                      }
                                    },
                                    failure: (failure) {
                                      ToastService.showError(failure.message);
                                    },
                                  );
                                },
                              );
                            }
                          : null,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
