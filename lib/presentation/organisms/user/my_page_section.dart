import 'package:flutter/material.dart';
import 'package:we/core/utils/membership_level.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/shadows.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/cards/user/user_menu_list.dart';

// Data model for a menu list item
class MyPageMenuItemData {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  MyPageMenuItemData({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

class MyPageSection extends StatelessWidget {
  final String name;
  final MembershipLevel membershipLevel;
  final String points;
  final String recommendationCount;
  final List<MyPageMenuItemData> menuItems;

  const MyPageSection({
    super.key,
    required this.name,
    required this.membershipLevel,
    required this.points,
    required this.recommendationCount,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Combined user greeting and statistics card
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: AppShadow.card,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.layoutPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting section
                Text('안녕하세요, $name님!', style: AppTextStyles.heading3Bold),
                const SizedBox(height: 4),
                Text(
                  membershipLevel.displayName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: membershipLevel.color,
                  ),
                ),
                const SizedBox(height: AppSpacing.layoutPadding),
                // Divider
                const Divider(),
                const SizedBox(height: AppSpacing.layoutPadding),
                // Statistics section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '보유 포인트',
                            style: AppTextStyles.bodyRegular.copyWith(
                              color: AppColors.textDisabled,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            points,
                            style: AppTextStyles.heading3Bold.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '내 추천 현황',
                            style: AppTextStyles.bodyRegular.copyWith(
                              color: AppColors.textDisabled,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            recommendationCount,
                            style: AppTextStyles.heading3Bold.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.space20),
        // Menu list
        UserMenuListCard(
          items: menuItems
              .map(
                (item) => MenuListItem(
                  icon: item.icon,
                  title: item.title,
                  onTap: item.onTap,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
