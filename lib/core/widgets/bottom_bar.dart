import 'package:flutter/material.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/typography.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primaryDefault,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTextStyles.subBold.copyWith(
          color: AppColors.primaryDefault,
        ),
        unselectedLabelStyle: AppTextStyles.subRegular.copyWith(
          color: AppColors.textSecondary,
        ),
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 24),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, size: 24),
            label: '제품',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group, size: 24),
            label: '추천도',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded, size: 24),
            label: '마이',
          ),
        ],
      ),
    );
  }
}
