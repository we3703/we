import 'package:flutter/material.dart';
import 'package:we/core/theme/colors.dart';

class AppTextStyles {
  static final String fontFamily = 'Pretendard';

  static const double letterSpacingRatio = -0.025;

  static final TextStyle heading1Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 28 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading1Medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 28 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading1Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 28 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading2Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 24 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading2Medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 24 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading2Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 24 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading3Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 20 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading3Medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 20 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading3Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 20 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  // Body Text - Sub1 (기본값으로 사용)
  static final TextStyle bodyBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 16 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 16 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 16 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle subBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    height: 1.5,
    letterSpacing: 14 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle subMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 14 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );

  static final TextStyle subRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 14 * letterSpacingRatio,
    color: AppColors.textPrimary,
  );
}
