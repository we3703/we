import 'package:flutter/material.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/radius.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/theme/typography.dart';

/// The main theme configuration for the application.
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // 1. Color Scheme
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryDefault,
        onPrimary: AppColors.textInverse,
        secondary: AppColors.primaryDefault,
        onSecondary: AppColors.textInverse,
        error: AppColors.error,
        onError: AppColors.textInverse,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),

      // 2. Scaffold Background Color
      scaffoldBackgroundColor: AppColors.surface,

      // 3. Text Theme
      textTheme: TextTheme(
        // Headings
        displayLarge: AppTextStyles.heading1Bold,
        displayMedium: AppTextStyles.heading2Bold,
        displaySmall: AppTextStyles.heading3Bold,

        headlineLarge: AppTextStyles.heading1Medium,
        headlineMedium: AppTextStyles.heading2Medium,
        headlineSmall: AppTextStyles.heading3Medium,

        // Body
        bodyLarge: AppTextStyles.bodyRegular,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodyRegular,

        // Title (used for AppBar titles etc.)
        titleLarge: AppTextStyles.heading3Medium,
        titleMedium: AppTextStyles.bodyBold,
        titleSmall: AppTextStyles.bodyMedium,

        // Label (used for buttons etc.)
        labelLarge: AppTextStyles.bodyBold,
        labelMedium: AppTextStyles.bodyMedium,
        labelSmall: AppTextStyles.bodyRegular,
      ),

      // 4. AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: AppTextStyles.heading3Medium,
        iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
      ),

      // 5. Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
        margin: EdgeInsets.zero,
      ),

      // 6. Input Decoration Theme (for TextField)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space8,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(
            color: AppColors.primaryDefault,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textSecondary,
        ),
        hintStyle: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // 7. Other component themes can be added here
      // e.g., elevatedButtonTheme, textButtonTheme, etc.
    );
  }

  // Private constructor to prevent instantiation
  AppTheme._();
}
