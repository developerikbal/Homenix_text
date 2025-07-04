import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4CAF50);
  static const Color secondary = Color(0xFF2E7D32);
  static const Color accent = Color(0xFF00BCD4);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color text = Colors.black87;
  static const Color textLight = Colors.white;
  static const Color error = Colors.redAccent;
}

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textLight,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textLight),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      // background is deprecated, use surface instead
      error: AppColors.error,
      onPrimary: AppColors.textLight,
      onSecondary: AppColors.textLight,
      onSurface: AppColors.text,
      // onBackground is deprecated, use onSurface instead
      onError: AppColors.textLight,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.text),
      bodyMedium: TextStyle(fontSize: 16, color: AppColors.text),
      labelLarge: TextStyle(fontSize: 14, color: AppColors.text),
    ),
    useMaterial3: true,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.textLight,
      elevation: 0,
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: Colors.grey[850]!,
      // background is deprecated, use surface instead
      error: AppColors.error,
      onPrimary: AppColors.textLight,
      onSecondary: AppColors.textLight,
      onSurface: AppColors.textLight,
      // onBackground is deprecated, use onSurface instead
      onError: AppColors.textLight,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textLight),
      bodyMedium: TextStyle(fontSize: 16, color: AppColors.textLight),
      labelLarge: TextStyle(fontSize: 14, color: AppColors.textLight),
    ),
    useMaterial3: true,
  );
}
