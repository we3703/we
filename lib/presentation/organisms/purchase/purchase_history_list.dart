import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/cards/purchase/purchase_card.dart';
import 'package:we/presentation/molecules/indicator/page_indicator.dart';

// Data model for a single purchased item
class PurchasedItemData {
  final String imageUrl;
  final String productName;
  final String productDescription; // From ProductCard, can be empty
  final int price;
  final String purchaseDate;
  final VoidCallback? onRepurchasePressed;

  PurchasedItemData({
    required this.imageUrl,
    required this.productName,
    this.productDescription = '', // Default to empty
    required this.price,
    required this.purchaseDate,
    this.onRepurchasePressed,
  });
}

class PurchaseHistoryList extends StatefulWidget {
  final List<PurchasedItemData> purchasedItems;
  final int totalPages;
  final int initialPage;
  final Function(int page) onPageChanged;

  const PurchaseHistoryList({
    super.key,
    required this.purchasedItems,
    required this.totalPages,
    this.initialPage = 1,
    required this.onPageChanged,
  });

  @override
  State<PurchaseHistoryList> createState() => _PurchaseHistoryListState();
}

class _PurchaseHistoryListState extends State<PurchaseHistoryList> {
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.purchasedItems.length,
          itemBuilder: (context, index) {
            final item = widget.purchasedItems[index];
            return PurchaseCard(
              imageUrl: item.imageUrl,
              productName: item.productName,
              price: item.price,
              purchaseDate: item.purchaseDate,
              onRepurchasePressed: item.onRepurchasePressed,
            );
          },
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.space12),
        ),
        if (widget.totalPages > 1) ...[
          const SizedBox(height: AppSpacing.space32),
          PageIndicator(
            currentPage: _currentPage,
            totalPages: widget.totalPages,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
              widget.onPageChanged(page);
            },
          ),
        ],
      ],
    );
  }
}
