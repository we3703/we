import 'package:flutter/material.dart';
import 'package:we/presentation/molecules/cards/purchase/purchase_summary_card.dart';
import 'package:we/presentation/molecules/indicator/page_indicator.dart';
import 'package:we/presentation/molecules/tab/category_tab_bar.dart';
import 'package:we/presentation/foundations/spacing.dart';

// This would likely come from a data layer
class PointHistoryItemData {
  final String title;
  final String date;
  final String amount;
  final String resultingBalance;

  PointHistoryItemData({
    required this.title,
    required this.date,
    required this.amount,
    required this.resultingBalance,
  });
}

class PointHistorySection extends StatefulWidget {
  final List<PointHistoryItemData> historyItems;
  final int totalPages;
  final int initialTabIndex;
  final int initialPage;
  final Function(int tabIndex) onTabChanged;
  final Function(int page) onPageChanged;

  const PointHistorySection({
    super.key,
    required this.historyItems,
    required this.totalPages,
    this.initialTabIndex = 0,
    this.initialPage = 1,
    required this.onTabChanged,
    required this.onPageChanged,
  });

  @override
  State<PointHistorySection> createState() => _PointHistorySectionState();
}

class _PointHistorySectionState extends State<PointHistorySection> {
  late int _currentTabIndex;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentTabIndex = widget.initialTabIndex;
    _currentPage = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['충전', '사용', '수당']; // "Charge", "Use", "Earnings"

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.layoutPadding,
          ),
          child: CategoryTabBar(
            currentIndex: _currentTabIndex,
            tabs: tabs,
            onTabChanged: (index) {
              setState(() {
                _currentTabIndex = index;
                _currentPage = 1; // Reset page when tab changes
              });
              widget.onTabChanged(index);
            },
          ),
        ),
        const SizedBox(height: AppSpacing.space20),
        // History List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.historyItems.length,
          itemBuilder: (context, index) {
            final item = widget.historyItems[index];
            return PurchaseSummaryCard(
              title: item.title,
              date: item.date,
              amount: item.amount,
              resultingBalance: item.resultingBalance,
            );
          },
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.space12),
        ),
        const SizedBox(height: AppSpacing.space32),
        // Pagination
        if (widget.totalPages > 1)
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
    );
  }
}
