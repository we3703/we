import 'package:flutter/material.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/widgets/card/product_card.dart';
import 'package:we/features/main/widgets/section_header.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: '신규 제품', onMoreTap: () {}),
        SizedBox(height: AppSpacing.space24),
        SizedBox(
          height: 215,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? AppSpacing.layoutPadding : 0,
                  right: 12,
                ),
                child: SizedBox(
                  width: 160,
                  child: ProductCard(
                    title: 'title',
                    description: 'description',
                    originalPrice: 100000,
                    price: 90000,
                    onTap: () {},
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
