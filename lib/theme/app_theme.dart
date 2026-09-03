import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Theme Data for Quran MVP Application
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'NotoNaskhArabic', // اعمال فونت پیش‌فرض سراسری

      // رنگ اصلی
      primaryColor: AppColors.primaryDark,
      primarySwatch: MaterialColor(
        AppColors.primaryDark.value,
        {
          50: AppColors.primaryDark.withOpacity(0.1),
          100: AppColors.primaryDark.withOpacity(0.2),
          200: AppColors.primaryDark.withOpacity(0.3),
          300: AppColors.primaryDark.withOpacity(0.4),
          400: AppColors.primaryDark.withOpacity(0.5),
          500: AppColors.primaryDark,
          600: AppColors.primaryMedium,
          700: AppColors.primaryLight,
          800: AppColors.primaryLight.withOpacity(0.8),
          900: AppColors.primaryLight.withOpacity(0.9),
        },
      ),

      // رنگ‌های Scaffold و Background
      scaffoldBackgroundColor: AppColors.bgCream,
      canvasColor: AppColors.bgCream,

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'NotoNaskhArabic',
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'NotoNaskhArabic',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        displayMedium: TextStyle(
          fontFamily: 'NotoNaskhArabic',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'NotoNaskhArabic',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        titleLarge: TextStyle(
          fontFamily: 'NotoNaskhArabic',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        titleMedium: TextStyle(
          fontFamily: 'NotoNaskhArabic',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),
        titleSmall: TextStyle(
          fontFamily: 'NotoNaskhArabic',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'NotoNaskhArabic',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textDark,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'NotoNaskhArabic',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textDark,
        ),
        bodySmall: TextStyle(
          fontFamily: 'NotoNaskhArabic',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textGrey,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            color: AppColors.dividerColor,
            width: 0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            color: AppColors.dividerColor,
            width: 0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          borderSide: BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        hintStyle: const TextStyle(
          fontFamily: 'NotoNaskhArabic',
          color: AppColors.textGrey,
          fontSize: 14,
        ),
        prefixIconColor: AppColors.primaryDark,
        suffixIconColor: AppColors.primaryDark,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryDark,
          side: const BorderSide(
            color: AppColors.primaryDark,
            width: 2,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // BottomNavigationBar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.textGrey,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerColor,
        thickness: 0.5,
        space: 0,
      ),
    );
  }
}
