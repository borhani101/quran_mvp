import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../theme/app_colors.dart';

/// لیست آیتم سوره - نمایش هر سوره به صورت یک ردیف ساده
class SurahListItem extends StatelessWidget {
  final Surah surah;
  final int index;
  final VoidCallback? onTap;

  const SurahListItem({
    super.key,
    required this.surah,
    required this.index,
    this.onTap,
  });

  /// تبدیل عدد به ارقام فارسی
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

  String _displayInfoInPersian() {
    return '${surah.revelationPlace} · ${_toPersianNumber(surah.verseCount)} آیه';
  }

  @override
  Widget build(BuildContext context) {
    final persianNumber = _toPersianNumber(surah.number);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 78,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.dividerColor),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            /// شماره سوره با فریم اسلیمی
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'lib/assets/numberSvg.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
                Transform.translate(
                  offset: const Offset(-2, 0),
                  child: Text(
                    persianNumber,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),

            /// نام سوره و اطلاعات
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// نام سوره
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
                  const SizedBox(height: 2),
                  /// نوع و تعداد آیات
                  Text(
                    _displayInfoInPersian(),
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textGrey,
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
