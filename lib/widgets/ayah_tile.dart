import 'package:flutter/material.dart';
import '../models/ayah.dart';
import '../services/bookmark_service.dart';

class AyahTile extends StatefulWidget {
  final Ayah ayah;
  final int? surahNumber;
  final String? surahName;
  final int? ayahIndex;
  final bool isHighlighted;
  final bool isBookmarked;
  final VoidCallback? onBookmarkToggle;

  const AyahTile({
    Key? key,
    required this.ayah,
    this.surahNumber,
    this.surahName,
    this.ayahIndex,
    this.isHighlighted = false,
    this.isBookmarked = false,
    this.onBookmarkToggle,
  }) : super(key: key);

  @override
  State<AyahTile> createState() => _AyahTileState();
}

class _AyahTileState extends State<AyahTile> {
  late bool _isBookmarked;

  int? get _effectiveSurahNumber {
    if (widget.surahNumber != null) return widget.surahNumber;
    try {
      final map = widget.ayah.toJson();
      return map['surahNumber'] ?? map['surah_number'] ?? map['surahId'];
    } catch (_) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.isBookmarked;
    _checkBookmark();
  }

  void _checkBookmark() async {
    final sNum = _effectiveSurahNumber;
    final aNum = widget.ayah.number;
    if (sNum != null) {
      final marked = await BookmarkService.isBookmarked(sNum, aNum);
      if (mounted) setState(() => _isBookmarked = marked);
    }
  }

  void _toggleBookmark() async {
    final sNum = _effectiveSurahNumber;
    final aNum = widget.ayah.number;

    if (widget.onBookmarkToggle != null) {
      widget.onBookmarkToggle!();
    } else if (sNum != null) {
      if (_isBookmarked) {
        await BookmarkService.removeBookmark(sNum, aNum);
      } else {
        await BookmarkService.addBookmark(sNum, aNum);
      }
      setState(() => _isBookmarked = !_isBookmarked);
    }
  }

  // استخراج ایمن متون آیه بدون روبرو شدن با NoSuchMethodError
  Map<String, String?> _extractTexts() {
    String arabic = '';
    String? translation;

    try {
      // تبدیل مدل به Map جهت بررسی ایمن کلیدها
      final Map<String, dynamic> map = widget.ayah.toJson();
      
      arabic = (map['text'] ?? 
                map['arabic'] ?? 
                map['arabicText'] ?? 
                map['content'] ?? 
                'آیه ${widget.ayah.number}').toString();

      translation = map['translation']?.toString() ?? 
                    map['persianText']?.toString() ?? 
                    map['farsi']?.toString() ?? 
                    map['persian']?.toString();
    } catch (_) {
      arabic = 'آیه ${widget.ayah.number}';
    }

    return {'arabic': arabic, 'translation': translation};
  }

  @override
  Widget build(BuildContext context) {
    final texts = _extractTexts();
    final String arabicText = texts['arabic'] ?? '';
    final String? translationText = texts['translation'];

    return Container(
      color: widget.isHighlighted ? Theme.of(context).primaryColor.withOpacity(0.15) : null,
      child: ListTile(
        title: Text(
          arabicText,
          textAlign: TextAlign.right,
          style: const TextStyle(fontFamily: 'Amiri', fontSize: 18, color: Colors.black),
        ),
        subtitle: (translationText != null && translationText.isNotEmpty)
            ? Text(
                translationText,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              )
            : null,
        trailing: IconButton(
          icon: Icon(
            _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: _isBookmarked ? Theme.of(context).primaryColor : Colors.grey,
          ),
          onPressed: _toggleBookmark,
        ),
      ),
    );
  }
}