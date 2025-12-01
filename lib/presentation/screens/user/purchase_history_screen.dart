import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/organisms/purchase/purchase_history_list.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  static const routeName = '/purchaseHistory';

  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
    final List<PurchasedItemData> purchasedItems = List.generate(
      10,
      (index) => PurchasedItemData(
        imageUrl: 'https://picsum.photos/seed/purchase$index/200/200',
        productName: '제품 이름 제품 이름 $index',
        price: 50000,
        purchaseDate: '2025.11.16',
        onRepurchasePressed: () {
          // TODO: Implement repurchase logic
        },
      ),
    );

    return Scaffold(
      appBar: const AppHeader(title: '구매 내역', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.layoutPadding),
        child: PurchaseHistoryList(
          purchasedItems: purchasedItems,
          totalPages: 2,
          onPageChanged: (page) {
            // TODO: Handle page change
          },
        ),
      ),
    );
  }
}
