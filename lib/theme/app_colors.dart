import 'package:flutter/material.dart';

/// رنگ‌های تم اپلیکیشن قرآن
class AppColors {
  // --- توکن‌های طراحی جدید (Minimal Green & Cream) ---
  static const Color background = Color(0xFFF9F7F1); // پس‌زمینه کرم روشن
  static const Color cardBackground = Color(0xFFFAF7F2); // پس‌زمینه کارت‌ها
  static const Color primaryGreen = Color(0xFF1B3B2B); // سبز تیره سنتی
  static const Color goldAccent = Color(0xFFC29B38); // طلایی ظریف
  static const Color searchBarBg = Color(0xFFF0ECE1); // پس‌زمینه سرچ‌بار
  static const Color borderLight = Color(0xFFE5DFC9); // بوردر و حاشیه‌ها
  static const Color textDark = Color(0xFF1B3B2B); // متن اصلی
  static const Color textMuted = Color(0xFF8C827A); // متن ثانویه و کم‌رنگ
  static const Color bottomBarBg = Color(0xFFF5F2EA); // پس‌زمینه نوار پایین

  // --- حفظ متغیرهای قبلی برای سازگاری با سایر ویجت‌ها ---
  static const Color primaryDark = Color(0xFF1B3B2B);
  static const Color primaryMedium = Color(0xFF2A523E);
  static const Color primaryLight = Color(0xFF3D6B53);

  static const Color bgCream = Color(0xFFF9F7F1);
  static const Color bgLight = Color(0xFFFAF7F2);
  static const Color bgGrey = Color(0xFFF0ECE1);

  static const Color goldDark = Color(0xFFA88428);
  static const Color textGrey = Color(0xFF8C827A);
  static const Color textLight = Color(0xFFB5ADA4);

  static const Color cardBg = Color(0xFFFAF7F2);
  static const Color dividerColor = Color(0xFFE5DFC9);
  static const Color shadowColor = Color(0x08000000);

  static const Color surahMakki = Color(0xFF1B3B2B);
  static const Color surahMadani = Color(0xFF8C827A);
}

/// گرادیان‌ها (Gradients)
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

/// سایه‌ها (Shadows)
class AppShadows {
  static const BoxShadow lightShadow = BoxShadow(
    color: Color(0x0A000000),
    blurRadius: 6.0,
    offset: Offset(0, 2),
    spreadRadius: 0,
  );

  static const BoxShadow mediumShadow = BoxShadow(
    color: Color(0x12000000),
    blurRadius: 12.0,
    offset: Offset(0, 4),
    spreadRadius: 0,
  );

  static List<BoxShadow> cardShadows = [
    const BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8.0,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];
}
