import 'package:we/presentation/foundations/image.dart';
import 'package:we/presentation/molecules/image/image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/utils/date_formatter.dart';
import 'package:we/core/utils/number_formatter.dart';
import 'package:we/domain/entities/product/paginated_products_entity.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/cards/notice/notice_card.dart';
import 'package:we/presentation/molecules/cards/product/product_card.dart';
import 'package:we/presentation/screens/notice/notice_detail_screen.dart';
import 'package:we/presentation/screens/notice/notice_list_screen.dart';
import 'package:we/presentation/screens/main/main_scaffold.dart';
import 'package:we/presentation/screens/notice/notice_view_model.dart';
import 'package:we/presentation/screens/product/product_detail_screen.dart';
import 'package:we/presentation/screens/product/product_view_model.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Load initial data
      // User info is already loaded from login, no need to call getMe() again
      context.read<NoticeViewModel>().getNotices();
      context.read<ProductViewModel>().getProducts(page: 1, limit: 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.layoutPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder area
            LayoutBuilder(
              builder: (context, constraints) {
                return ImageCarousel(
                  imageUrls: ImageStorage.banners,
                  height: constraints.maxWidth * 2 / 3, // 3:2 비율
                  isAsset: true,
                  fit: BoxFit.contain,
                );
              },
            ),
            const SizedBox(height: AppSpacing.space32),
            _buildSectionHeader(context, '최신 공지사항', () {
              Navigator.of(context).pushNamed(NoticeListScreen.routeName);
            }),
            const SizedBox(height: AppSpacing.space12),
            // Latest notice
            Selector<
              NoticeViewModel,
              ({bool isLoading, List<dynamic>? notices})
            >(
              selector: (_, vm) =>
                  (isLoading: vm.isLoading, notices: vm.notices),
              builder: (context, noticeState, child) {
                if (noticeState.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (noticeState.notices != null &&
                    noticeState.notices!.isNotEmpty) {
                  final firstNotice = noticeState.notices!.first;
                  return NoticeCard(
                    title: firstNotice.title,
                    date: formatDate(firstNotice.createdAt),
                    description: firstNotice.content,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NoticeDetailScreen(
                            noticeId: firstNotice.id.toString(),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Text('공지사항이 없습니다.');
                }
              },
            ),
            const SizedBox(height: AppSpacing.space40),
            _buildSectionHeader(context, '추천 제품', () {
              // Navigate to MainScaffold with product tab (index 1)
              Navigator.of(
                context,
              ).pushReplacementNamed(MainScaffold.routeName, arguments: 1);
            }),
            const SizedBox(height: AppSpacing.space12),
            // Latest products
            Selector<
              ProductViewModel,
              ({bool isLoading, PaginatedProductsEntity? paginatedProducts})
            >(
              selector: (_, vm) => (
                isLoading: vm.isLoading,
                paginatedProducts: vm.paginatedProducts,
              ),
              builder: (context, productState, child) {
                if (productState.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (productState.paginatedProducts != null &&
                    productState.paginatedProducts!.items.isNotEmpty) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productState.paginatedProducts!.items.length > 2
                        ? 2
                        : productState.paginatedProducts!.items.length,
                    itemBuilder: (context, index) {
                      final product =
                          productState.paginatedProducts!.items[index];
                      return ProductCard(
                        imageUrl: product.images.isNotEmpty
                            ? product.images.first
                            : 'https://via.placeholder.com/200',
                        productName: product.name,
                        productDescription: product.description,
                        price: product.price,
                        salePrice: product.salePrice,
                        quantityRemaining: '${formatNumber(product.stock)}개 남음',
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
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppSpacing.space12),
                  );
                } else {
                  return const Text('제품이 없습니다.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    VoidCallback onViewMore,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.heading3Bold),
        TextButton(
          onPressed: onViewMore,
          child: Text('더보기', style: AppTextStyles.bodyRegular),
        ),
      ],
    );
  }
}
