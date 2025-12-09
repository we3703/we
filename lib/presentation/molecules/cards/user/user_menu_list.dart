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
        children: [
          for (int i = 0; i < items.length; i++) ...[
            InkWell(
              onTap: items[i].onTap,
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
                      icon: items[i].icon,
                      color: AppColors.textPrimary,
                    ),
                    const SizedBox(width: AppSpacing.layoutPadding),
                    Expanded(
                      child: Text(
                        items[i].title,
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
            ),
            if (i < items.length - 1)
              const Divider(
                height: 1,
                thickness: 1,
                color: AppColors.border,
                indent: AppSpacing.layoutPadding,
                endIndent: AppSpacing.layoutPadding,
              ),
          ],
        ],
      ),
    );
  }
}
