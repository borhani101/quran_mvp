import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../theme/app_colors.dart';
import '../utils/persian_number_helper.dart';

class SurahListItem extends StatelessWidget {
  final Surah surah;
  final VoidCallback onTap;

  const SurahListItem({
    Key? key,
    required this.surah,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int count = surah.verseCount > 0 ? surah.verseCount : surah.ayahs.length;
    final String verseText = '${PersianNumberHelper.toPersian(count)} آیه';
    final String placeText = surah.revelationPlace;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.goldAccent.withValues(alpha: 0.25),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // نشان شماره سوره در سمت راست
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.goldAccent.withValues(alpha: 0.6),
                        width: 1.2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      PersianNumberHelper.toPersian(surah.number),
                      style: const TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // نام سوره و مشخصات
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          surah.name,
                          style: const TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$verseText • $placeText',
                          style: TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // آیکون فلش راهنما در سمت چپ
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: AppColors.goldAccent.withValues(alpha: 0.8),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
