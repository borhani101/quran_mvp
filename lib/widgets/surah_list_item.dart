import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../theme/app_colors.dart';

class SurahListItem extends StatelessWidget {
  final Surah surah;
  final VoidCallback onTap;

  const SurahListItem({
    super.key,
    required this.surah,
    required this.onTap,
  });

  String _toPersianNumber(dynamic number) {
    if (number == null) return '';
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return number.toString().split('').map((char) {
      final index = int.tryParse(char);
      return index != null ? persianDigits[index] : char;
    }).join('');
  }

  @override
  Widget build(BuildContext context) {
    final bool isMeccan = surah.type.toLowerCase().contains('makki') ||
        surah.type.contains('مکی');

    final String displayName = (surah.nameFa != null && surah.nameFa!.isNotEmpty)
        ? surah.nameFa!
        : surah.nameAr;

    final String juzText = surah.juz != null ? ' • جزء ${_toPersianNumber(surah.juz)}' : '';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      elevation: 0.5,
      color: AppColors.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.dividerColor, width: 0.8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // شماره ترتیب سوره
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.bgGrey,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.goldAccent, width: 1.2),
                ),
                alignment: Alignment.center,
                child: Text(
                  _toPersianNumber(surah.number),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.primaryMedium,
                    fontFamily: 'IRANSans',
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // نام سوره و جزئیات
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textDark,
                        fontFamily: 'IRANSans',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${isMeccan ? "مکی" : "مدنی"} • ${_toPersianNumber(surah.verseCount)} آیه$juzText',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textGrey,
                        fontFamily: 'IRANSans',
                      ),
                    ),
                  ],
                ),
              ),

              // نام عربی سوره
              Text(
                surah.nameAr,
                style: const TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
