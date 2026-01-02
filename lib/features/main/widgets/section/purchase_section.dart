import 'package:flutter/material.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/widgets/card/purchase_card.dart';
import 'package:we/features/main/widgets/section_header.dart';

class PurchaseSection extends StatelessWidget {
  const PurchaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: '최근 구매 내역', onMoreTap: () {}),
        SizedBox(height: AppSpacing.space24),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.layoutPadding,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: AppSpacing.space12),
                child: PurchaseCard(
                  productName: '제품 1번 구매 완료',
                  date: '2025-12-29 (월)', // TODO: 이거 포맷팅 고민
                  price: -100000,
                  onTap: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
