import 'package:chatapp/res/res_exports.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
abstract class AppTheme {
  static const AppBarTheme appBarTheme =
      AppBarTheme(centerTitle: false, elevation: 0);

  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData.light().copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: AppColors.contentColorLightTheme),
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: AppColors.contentColorLightTheme),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        error: AppColors.errorColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.contentColorLightTheme.withOpacity(0.7),
        unselectedItemColor: AppColors.contentColorLightTheme.withOpacity(0.32),
        selectedIconTheme: const IconThemeData(color: AppColors.primaryColor),
        showUnselectedLabels: true,
      ),
    );
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData.dark().copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.contentColorLightTheme,
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: AppColors.contentColorDarkTheme),
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: AppColors.contentColorDarkTheme),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        error: AppColors.errorColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.contentColorLightTheme,
        selectedItemColor: Colors.white70,
        unselectedItemColor: AppColors.contentColorDarkTheme.withOpacity(0.32),
        selectedIconTheme: const IconThemeData(color: AppColors.primaryColor),
        showUnselectedLabels: true,
      ),
    );
  }
}
