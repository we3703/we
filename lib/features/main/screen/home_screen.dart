import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/features/main/widgets/section/banner_section.dart';
import 'package:we/features/main/widgets/section/notice_section.dart';
import 'package:we/features/main/widgets/section/product_section.dart';
import 'package:we/features/main/widgets/section/purchase_section.dart';
import 'package:we/presentation/screens/notice/notice_view_model.dart';
import 'package:we/presentation/screens/product/product_view_model.dart';
import 'package:we/presentation/screens/order/order_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NoticeViewModel>().getNotices();
      context.read<ProductViewModel>().getProducts(page: 1, limit: 10);
      context.read<OrderViewModel>().getMyOrders(page: 1, limit: 3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 배너 섹션
          SizedBox(height: AppSpacing.space16),
          BannerSection(),
          SizedBox(height: AppSpacing.sectionPadding),

          // 신규 제품 섹션
          ProductSection(),
          SizedBox(height: AppSpacing.sectionPadding),

          // 새 공지사항 섹션
          NoticeSection(),
          SizedBox(height: AppSpacing.sectionPadding),

          // 최근 구매 내역 섹션
          PurchaseSection(),
          SizedBox(height: AppSpacing.sectionPadding),
        ],
      ),
    );
  }
}
