import 'package:flutter/material.dart';

/// رنگ‌های تم اپلیکیشن قرآن MVP
/// App Colors - Design Tokens for Quran MVP
class AppColors {
  // رنگ‌های اصلی (Primary Colors)
  static const Color primaryDark = Color(0xFF1F4E3D); // سبز یشمی تیره
  static const Color primaryMedium = Color(0xFF2A6B57); // سبز متوسط
  static const Color primaryLight = Color(0xFF3D8B71); // سبز روشن

  // رنگ‌های پس‌زمینه (Background Colors)
  static const Color bgCream = Color(0xFFFBF8F0); // کرم ملایم (شبیه کاغذ قرآنی)
  static const Color bgLight = Color(0xFFFFFAF5); // سفید ملایم
  static const Color bgGrey = Color(0xFFF5F3EF); // خاکستری روشن

  // رنگ‌های تاکیدی (Accent Colors)
  static const Color goldAccent = Color(0xFFD4AF7C); // طلایی ملایم
  static const Color goldDark = Color(0xFFC19A4A); // طلایی تیره

  // رنگ‌های متن (Text Colors)
  static const Color textDark = Color(0xFF2C3E50); // متن تیره
  static const Color textGrey = Color(0xFF7F8C8D); // متن خاکستری
  static const Color textLight = Color(0xFFBDC3C7); // متن روشن

  // رنگ‌های حالت (Status Colors)
  static const Color cardBg = Color(0xFFFFFDFA); // رنگ کارت‌ها
  static const Color dividerColor = Color(0xFFE8DDD0); // خطوط جداکننده
  static const Color shadowColor = Color(0xFF000000); // رنگ سایه

  // رنگ‌های سوره‌های مختلف
  static const Color surahMakki = Color(0xFF1F4E3D); // مکی
  static const Color surahMadani = Color(0xFF8B5A3C); // مدنی
}

/// الأنماط والتدرجات (Gradients)
class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primaryMedium,
      AppColors.primaryDark,
    ],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.goldAccent,
      AppColors.goldDark,
    ],
  );
}

/// الظلال (Shadows)
class AppShadows {
  static const BoxShadow lightShadow = BoxShadow(
    color: AppColors.shadowColor,
    blurRadius: 6.0,
    offset: Offset(0, 2),
    spreadRadius: 0,
  );

  static const BoxShadow mediumShadow = BoxShadow(
    color: AppColors.shadowColor,
    blurRadius: 12.0,
    offset: Offset(0, 4),
    spreadRadius: 0,
  );

  static List<BoxShadow> cardShadows = [
    const BoxShadow(
      color: Color(0x1A000000), // ملایم و شفاف
      blurRadius: 8.0,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];
}
