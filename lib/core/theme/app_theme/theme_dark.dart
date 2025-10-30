import 'package:evently/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.purple,
    onPrimary: AppColors.darkPurple,
    secondary: AppColors.offWhite,
    onSecondary: AppColors.darkPurple,
    error: Colors.red,
    onError: Colors.white,
    surface: AppColors.darkPurple,
    onSurface: AppColors.offWhite,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkPurple,
    selectedItemColor: AppColors.offWhite,
    unselectedItemColor: AppColors.offWhite,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      padding: EdgeInsets.all(10),
      minimumSize: Size.fromHeight(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(16),
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.darkPurple,
    iconSize: 40,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(16),
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      foregroundColor: AppColors.purple,
      side: BorderSide(color: AppColors.purple, width: 1),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.purple,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: AppColors.offWhite,
    suffixIconColor: AppColors.offWhite,
    hintStyle: TextStyle(fontSize: 14, color: AppColors.offWhite),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.purple, width: 1),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.offWhite, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.purple, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
  ),
);
