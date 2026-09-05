import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  @override
  Widget build(BuildContext context) {
    final persianNumber = _toPersianNumber(surah.number);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColors.bgCream,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            /// شماره سوره با فریم اسلیمی
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'lib/assets/surah_number_frame.svg',
                  width: 56,
                  height: 56,
                  colorFilter: const ColorFilter.mode(
                    AppColors.goldAccent,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  persianNumber,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),

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
                    surah.displayInfo,
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textGrey,
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            /// شماره ترتیب
            Text(
              '$index',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
