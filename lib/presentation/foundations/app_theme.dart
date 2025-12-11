import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';

/// The main theme configuration for the application.
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // 1. Color Scheme
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryGreen,
        onPrimary: AppColors.surface,
        secondary: AppColors.secondary,
        onSecondary: AppColors.textPrimary,
        error: AppColors.error,
        onError: AppColors.surface,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),

      // 2. Scaffold Background Color
      scaffoldBackgroundColor: AppColors.surface,

      // 3. Text Theme
      textTheme: TextTheme(
        // Headings
        displayLarge: AppTextStyles.heading1Bold.copyWith(
          color: AppColors.textPrimary,
        ),
        displayMedium: AppTextStyles.heading2Bold.copyWith(
          color: AppColors.textPrimary,
        ),
        displaySmall: AppTextStyles.heading3Bold.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineLarge: AppTextStyles.heading1Medium.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineMedium: AppTextStyles.heading2Medium.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineSmall: AppTextStyles.heading3Medium.copyWith(
          color: AppColors.textPrimary,
        ),

        // Body
        bodyLarge: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textPrimary,
        ),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        bodySmall: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textDisabled,
          fontSize: 14,
        ),

        // Title (used for AppBar titles etc.)
        titleLarge: AppTextStyles.heading3Medium.copyWith(
          color: AppColors.textPrimary,
        ),
        titleMedium: AppTextStyles.bodyBold.copyWith(
          color: AppColors.textPrimary,
        ),
        titleSmall: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),

        // Label (used for buttons etc.)
        labelLarge: AppTextStyles.bodyBold.copyWith(color: AppColors.surface),
        labelMedium: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        labelSmall: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textDisabled,
          fontSize: 12,
        ),
      ),

      // 4. AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: AppTextStyles.heading3Medium.copyWith(
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
      ),

      // 5. Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.zero,
      ),

      // 6. Input Decoration Theme (for TextField)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: AppColors.primaryGreen,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textDisabled,
        ),
        hintStyle: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textDisabled,
        ),
      ),

      // 7. Other component themes can be added here
      // e.g., elevatedButtonTheme, textButtonTheme, etc.
    );
  }

  // Private constructor to prevent instantiation
  AppTheme._();
}
