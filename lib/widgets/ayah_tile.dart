import 'package:flutter/material.dart';
import '../models/ayah.dart';

// یک ویجت ساده برای نمایش هر آیه
class AyahTile extends StatelessWidget {
  final Ayah ayah;
  final VoidCallback? onTap;

  const AyahTile({super.key, required this.ayah, this.onTap});

  @override
  Widget build(BuildContext context) {
    // استایل‌ها
    final arabicStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          height: 1.6,
        );
    final faStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          color: Colors.grey[800],
          height: 1.4,
        );

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // شماره آیه
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'آیه ${ayah.number}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                textDirection: TextDirection.rtl,
              ),
            ),
            const SizedBox(height: 6),
            // متن عربی
            Text(
              ayah.textAr,
              style: arabicStyle,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 8),
            // ترجمه فارسی
            Text(
              ayah.textFa,
              style: faStyle,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 6),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
