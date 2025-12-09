import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/domain/entities/product/paginated_products_entity.dart';
import 'package:we/domain/entities/user/my_info_entity.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/cards/notice/notice_card.dart';
import 'package:we/presentation/molecules/cards/product/product_card.dart';
import 'package:we/presentation/molecules/cards/user/user_status_card.dart';
import 'package:we/presentation/organisms/user/home_header_section.dart';
import 'package:we/presentation/screens/notice/notice_detail_screen.dart';
import 'package:we/presentation/screens/notice/notice_list_screen.dart';
import 'package:we/presentation/screens/main/main_scaffold.dart';
import 'package:we/presentation/screens/main/product_list_screen.dart';
import 'package:we/presentation/screens/main/recommendation_screen.dart';
import 'package:we/presentation/screens/notice/notice_view_model.dart';
import 'package:we/presentation/screens/product/product_detail_screen.dart';
import 'package:we/presentation/screens/product/product_view_model.dart';
import 'package:we/presentation/screens/points/point_management_screen.dart';
import 'package:we/presentation/screens/user/user_view_model.dart';

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
      context.read<UserViewModel>().getMe();
      context.read<NoticeViewModel>().getNotices();
      context.read<ProductViewModel>().getProducts(page: 1, limit: 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Selector<
            UserViewModel,
            ({bool isLoading, MyInfoEntity? myInfo, String? errorMessage})
          >(
            selector: (_, vm) => (
              isLoading: vm.isLoading,
              myInfo: vm.myInfo,
              errorMessage: vm.errorMessage,
            ),
            builder: (context, userState, child) {
              if (userState.isLoading && userState.myInfo == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final myInfo = userState.myInfo;
              if (myInfo == null) {
                return Center(
                  child: Text(userState.errorMessage ?? '사용자 정보를 불러올 수 없습니다.'),
                );
              }

              // Convert level string to MembershipLevel enum
              MembershipLevel membershipLevel;
              switch (myInfo.level.toLowerCase()) {
                case 'master':
                  membershipLevel = MembershipLevel.master;
                case 'diamond':
                  membershipLevel = MembershipLevel.diamond;
                  break;
                case 'gold':
                  membershipLevel = MembershipLevel.gold;
                  break;
                case 'silver':
                  membershipLevel = MembershipLevel.silver;
                  break;
                default:
                  membershipLevel = MembershipLevel.bronze;
              }

              final headerData = HomeHeaderData(
                name: myInfo.name,
                membershipLevel: membershipLevel,
                points: '${myInfo.points} P',
                recommendationCount: '${myInfo.totalReferrals}명',
              );

              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.layoutPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeaderSection(
                      data: headerData,
                      onRecommendPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(RecommendationScreen.routeName);
                      },
                      onChargePressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(PointManagementScreen.routeName);
                      },
                      onPurchasePressed: () {
                        // Navigate to MainScaffold with product tab (index 1)
                        Navigator.of(context).pushReplacementNamed(
                          MainScaffold.routeName,
                          arguments: 1,
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.space32),
                    _buildSectionHeader(context, '최신 공지사항', () {
                      Navigator.of(
                        context,
                      ).pushNamed(NoticeListScreen.routeName);
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
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (noticeState.notices != null &&
                            noticeState.notices!.isNotEmpty) {
                          final firstNotice = noticeState.notices!.first;
                          return NoticeCard(
                            title: firstNotice.title,
                            date: firstNotice.createdAt,
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
                    const SizedBox(height: AppSpacing.space32),
                    _buildSectionHeader(context, '추천 제품', () {
                      Navigator.of(
                        context,
                      ).pushNamed(ProductListScreen.routeName);
                    }),
                    const SizedBox(height: AppSpacing.space12),
                    // Latest products
                    Selector<
                      ProductViewModel,
                      ({
                        bool isLoading,
                        PaginatedProductsEntity? paginatedProducts,
                      })
                    >(
                      selector: (_, vm) => (
                        isLoading: vm.isLoading,
                        paginatedProducts: vm.paginatedProducts,
                      ),
                      builder: (context, productState, child) {
                        if (productState.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (productState.paginatedProducts != null &&
                            productState.paginatedProducts!.items.isNotEmpty) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                productState.paginatedProducts!.items.length > 2
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
                                price: '${product.price} P',
                                quantityRemaining: '${product.stock}개 남음',
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
              );
            },
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
