import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/app_colors.dart';

abstract class AppTheme {
  static ThemeData buildTheme({Brightness brightness = Brightness.dark}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        onPrimary: Colors.black,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        outline: Colors.white38,
      ).copyWith(
        primary: AppColors.primary,
      ),

      scaffoldBackgroundColor: AppColors.surface,
      cardColor: AppColors.surface,
      highlightColor: Colors.grey[700],
      dividerColor: AppColors.dividerDark,

      // sets text style for all texts
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 16, color: AppColors.textPrimary),
        bodyLarge: TextStyle(fontSize: 18, color: AppColors.textPrimary),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),

      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

    );
  }

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
