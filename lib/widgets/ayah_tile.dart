import 'package:flutter/material.dart';

import '../models/ayah.dart';
import '../services/bookmark_service.dart';
import '../theme/app_colors.dart';

class AyahTile extends StatefulWidget {
final Ayah ayah;
final int surahNumber;
final String surahName;
final int ayahIndex;
final bool isHighlighted;

const AyahTile({
super.key,
required this.ayah,
required this.surahNumber,
required this.surahName,
required this.ayahIndex,
this.isHighlighted = false,
});

@override
State<AyahTile> createState() => _AyahTileState();
}

class _AyahTileState extends State<AyahTile> {
bool _isBookmarked = false;

@override
void initState() {
super.initState();
_checkBookmarkStatus();
}

Future<void> _checkBookmarkStatus() async {
final result = await BookmarkService.isBookmarked(
surahNumber: widget.surahNumber,
ayahNumber: widget.ayah.number,
);

if (mounted) {
setState(() {
_isBookmarked = result;
});
}
}

Future<void> _toggleBookmark() async {
if (_isBookmarked) {
await BookmarkService.removeBookmark(
surahNumber: widget.surahNumber,
ayahNumber: widget.ayah.number,
);
} else {
await BookmarkService.addBookmark(
Bookmark(
surahNumber: widget.surahNumber,
surahName: widget.surahName,
ayahNumber: widget.ayah.number,
ayahText: widget.ayah.textAr,
),
);
}

if (mounted) {
setState(() {
_isBookmarked = !_isBookmarked;
});
}
}

String _toPersianNumber(int num) {
const map = {
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

return num
    .toString()
    .split('')
    .map((c) => map[c] ?? c)
    .join();
}

@override
Widget build(BuildContext context) {
return Container(
margin: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 8,
),
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: widget.isHighlighted
? AppColors.goldAccent.withOpacity(0.15)
    : AppColors.cardBg,
borderRadius: BorderRadius.circular(16),
border: Border.all(
color: widget.isHighlighted
? AppColors.goldAccent
    : AppColors.dividerColor.withOpacity(0.5),
),
boxShadow: [
BoxShadow(
color: AppColors.shadowColor.withOpacity(0.04),
blurRadius: 10,
offset: const Offset(0, 4),
),
],
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Row(
textDirection: TextDirection.rtl,
children: [
Container(
width: 36,
height: 36,
decoration: BoxDecoration(
shape: BoxShape.circle,
color: AppColors.goldAccent.withOpacity(0.2),
),
child: Center(
child: Text(
_toPersianNumber(widget.ayah.number),
style: const TextStyle(
color: AppColors.primaryDark,
fontWeight: FontWeight.bold,
),
),
),
),

const Spacer(),

IconButton(
icon: Icon(
_isBookmarked
? Icons.bookmark_rounded
    : Icons.bookmark_border_rounded,
color: _isBookmarked
? AppColors.goldDark
    : AppColors.textGrey,
),
onPressed: _toggleBookmark,
),
],
),

const SizedBox(height: 12),

Text(
widget.ayah.textAr,
textDirection: TextDirection.rtl,
textAlign: TextAlign.right,
style: const TextStyle(
fontSize: 22,
height: 2.0,
color: AppColors.primaryDark,
),
),

const SizedBox(height: 8),

Text(
widget.ayah.textFa,
textDirection: TextDirection.rtl,
textAlign: TextAlign.right,
style: const TextStyle(
fontSize: 14,
height: 1.8,
color: AppColors.textDark,
),
),
],
),
);
}
}
