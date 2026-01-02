import 'package:flutter/material.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/features/main/widgets/section/banner_section.dart';
import 'package:we/features/main/widgets/section/notice_section.dart';
import 'package:we/features/main/widgets/section/product_section.dart';
import 'package:we/features/main/widgets/section/purchase_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
