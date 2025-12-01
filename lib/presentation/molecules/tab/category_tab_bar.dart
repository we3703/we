import 'package:flutter/material.dart';
import 'package:we/presentation/molecules/tab/category_tab_item.dart';

class CategoryTabBar extends StatelessWidget {
  final int currentIndex;
  final List<String> tabs;
  final ValueChanged<int> onTabChanged;

  const CategoryTabBar({
    super.key,
    required this.currentIndex,
    required this.tabs,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(tabs.length, (index) {
        return Padding(
          // Add some spacing between tabs
          padding: const EdgeInsets.only(right: 24.0),
          child: CategoryTabItem(
            title: tabs[index],
            isSelected: currentIndex == index,
            onTap: () => onTabChanged(index),
          ),
        );
      }),
    );
  }
}
