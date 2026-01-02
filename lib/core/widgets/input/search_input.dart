import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we/core/config/constant.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/typography.dart';
import 'package:we/core/theme/radius.dart';

class SearchInput extends StatelessWidget {
  final String? placeholder;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onSearchTap;

  const SearchInput({
    super.key,
    this.placeholder = '검색할 제품을 입력하세요.',
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      style: AppTextStyles.bodyRegular.copyWith(
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textDisabled,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        // unfocused 상태
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(
            color: AppColors.border,
            width: 1.0,
          ),
        ),
        // focused 상태
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(
            color: AppColors.primaryDefault,
            width: 1.5,
          ),
        ),
        suffixIcon: IconButton(
          icon: SvgPicture.asset(
            AppConstant.searchIcon,
            width: 24,
            height: 24,
          ),
          onPressed: onSearchTap ?? () {
            if (controller != null && onSubmitted != null) {
              onSubmitted!(controller!.text);
            }
          },
        ),
      ),
    );
  }
}
