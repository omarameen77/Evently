import 'package:evently/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.purple,
    onPrimary: AppColors.lightBlue,
    secondary: AppColors.black,
    onSecondary: AppColors.lightBlue,
    error: Colors.red,
    onError: Colors.white,
    surface: AppColors.lightBlue,
    onSurface: AppColors.black,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.purple,
    iconSize: 40,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.purple,
    selectedItemColor: AppColors.lightBlue,
    unselectedItemColor: AppColors.lightBlue,
  ),
  // Filled Button Theme
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      padding: EdgeInsets.all(10),
      minimumSize: Size.fromHeight(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(16),
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  ),
  // Outlined Button Theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(16),
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      foregroundColor: AppColors.purple,
      side: BorderSide(color: AppColors.purple, width: 1),
    ),
  ),
  // App Bar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.purple,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),
  // Text Field Theme
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: AppColors.gray,
    suffixIconColor: AppColors.gray,
    hintStyle: TextStyle(fontSize: 14, color: AppColors.gray),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.gray, width: 1),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.gray, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.gray, width: 1),
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
