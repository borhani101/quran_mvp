import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../theme/app_colors.dart';

/// کارت سوره سفارشی (Custom Surah Card Widget)
/// Displays a Surah as a beautifully styled card matching the Quran app design
class SurahCard extends StatelessWidget {
  final Surah surah;
  final VoidCallback? onTap;
  final bool isHighlighted;

  const SurahCard({
    super.key,
    required this.surah,
    this.onTap,
    this.isHighlighted = false,
  });

  /// تبدیل عدد به ارقام فارسی
  /// Convert numbers to Persian/Arabic numerals
  String _toPersianNumber(int num) {
    const Map<String, String> persianNumbers = {
      '0': '۰',
      '1': '۱',
      '2': '۲',
      '3': '۳',
      '4': '۴',
      '5': '۵',
      '6': '۶',
      '7': '۷',
      '8': '۸',
      '9': '۹',
    };

    String str = num.toString();
    String result = '';
    for (int i = 0; i < str.length; i++) {
      result += persianNumbers[str[i]] ?? str[i];
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final persianNumber = _toPersianNumber(surah.number);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.dividerColor,
            width: 0.5,
          ),
          boxShadow: AppShadows.cardShadows,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              // سمت راست: شماره سوره در کادر اسلیمی ستاره‌ای
              // Right: Surah number in Islamic circle badge
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.accentGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldDark.withValues(alpha:0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    persianNumber,
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // خط جداکننده عمودی ملایم
              // Vertical divider
              Container(
                width: 1,
                height: 40,
                color: AppColors.dividerColor,
              ),
              const SizedBox(width: 12),

              // وسط و چپ: نام و اطلاعات سوره
              // Middle: Surah name and info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // نام سوره
                    Text(
                      surah.name,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // محل نزول و تعداد آیات
                    Text(
                      surah.displayInfo,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textGrey,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// کلاس برای مدیریت سایه‌های کارت
class AppShadows {
  static List<BoxShadow> cardShadows = [
    const BoxShadow(
      color: Color(0x1A000000), // سایه ملایم و شفاف
      blurRadius: 8.0,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];
}

/// Gradients برای استفاده در کارت‌ها
class AppGradients {
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.goldAccent,
      AppColors.goldDark,
    ],
  );
}
