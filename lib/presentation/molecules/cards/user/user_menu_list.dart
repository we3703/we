import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/foundations/icon_radio.dart';
import 'package:we/presentation/foundations/spacing.dart';

class MenuListItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  MenuListItem({required this.icon, required this.title, required this.onTap});
}

class UserMenuListCard extends StatelessWidget {
  final List<MenuListItem> items;

  const UserMenuListCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: items.map((item) {
          return InkWell(
            onTap: item.onTap,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.layoutPadding,
                vertical: 12.0, // Consistent vertical padding for list items
              ),
              child: Row(
                children: [
                  AppIcon.size24(
                    icon: item.icon,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(width: AppSpacing.layoutPadding),
                  Expanded(
                    child: Text(
                      item.title,
                      style: AppTextStyles.bodyRegular.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  AppIcon.size20(
                    icon: Icons.arrow_forward_ios,
                    color: AppColors.textDisabled,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
