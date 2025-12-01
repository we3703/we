import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/foundations/icon_radio.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: AppIcon.size20(
            icon: Icons.arrow_back_ios,
            color: currentPage > 1
                ? AppColors.textPrimary
                : AppColors.textDisabled,
          ),
          onPressed: currentPage > 1
              ? () => onPageChanged(currentPage - 1)
              : null,
        ),
        Row(
          children: List.generate(totalPages, (index) {
            final pageNum = index + 1;
            final isCurrent = pageNum == currentPage;
            return GestureDetector(
              onTap: () => onPageChanged(pageNum),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '$pageNum',
                  style: isCurrent
                      ? AppTextStyles.bodyBold.copyWith(
                          color: AppColors.textPrimary,
                        )
                      : AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.textDisabled,
                        ),
                ),
              ),
            );
          }),
        ),
        IconButton(
          icon: AppIcon.size20(
            icon: Icons.arrow_forward_ios,
            color: currentPage < totalPages
                ? AppColors.textPrimary
                : AppColors.textDisabled,
          ),
          onPressed: currentPage < totalPages
              ? () => onPageChanged(currentPage + 1)
              : null,
        ),
      ],
    );
  }
}
