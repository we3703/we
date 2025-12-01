import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/foundations/icon_radio.dart';

class SearchHeader extends StatelessWidget implements PreferredSizeWidget {
  final String hintText;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onSearchTap; // For a clickable search bar
  final TextEditingController? controller;
  final List<Widget>? actions;

  const SearchHeader({
    super.key,
    this.hintText = '검색어를 입력해주세요', // "Placeholder Text Input"
    this.onSubmitted,
    this.onSearchTap,
    this.controller,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: const Padding(
        padding: EdgeInsets.only(left: 16.0), // Padding for search icon
        child: AppIcon.size24(
          icon: Icons.search,
          color: AppColors.textDisabled,
        ),
      ),
      title: onSearchTap != null
          ? GestureDetector(
              onTap: onSearchTap,
              child: Container(
                height: 40, // Height for the clickable search bar
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.subSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  hintText,
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: AppColors.textDisabled,
                  ),
                ),
              ),
            )
          : TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.bodyRegular.copyWith(
                  color: AppColors.textDisabled,
                ),
                filled: true,
                fillColor: AppColors.subSurface,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: AppTextStyles.bodyRegular.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
      actions: actions,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
