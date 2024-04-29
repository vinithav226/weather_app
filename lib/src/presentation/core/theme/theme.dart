import 'package:coffee_shop/src/presentation/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
    ),
    colorScheme: const ColorScheme.light(
      secondary: AppColors.secondaryColor,
    ),
  );
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.dark(
      secondary: AppColors.secondaryColor,
    ),
  );
}
