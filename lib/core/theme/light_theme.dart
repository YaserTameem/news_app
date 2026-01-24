import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: LightColors.scaffoldBackground,
  primaryColor: LightColors.primaryColor,
  progressIndicatorTheme: ProgressIndicatorThemeData(color: LightColors.textPrimaryColor),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.bold,
      color: LightColors.textPrimaryColor,
    ),
    backgroundColor: Colors.white,
    centerTitle: true,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: LightColors.primaryColor,
      textStyle: TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: LightColors.buttonTextColor,
      backgroundColor: LightColors.primaryColor,
      textStyle: TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: LightColors.backgroundColor,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: LightColors.textSecondaryColor,
    selectedItemColor: LightColors.primaryColor,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(fontSize: AppSizes.sp12, fontWeight: FontWeight.w700),
    unselectedLabelStyle: TextStyle(fontSize: AppSizes.sp12, fontWeight: FontWeight.w700),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: LightColors.textSecondaryColor),
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    focusColor: Color(0xFFD1DAD6),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
  ),
);
