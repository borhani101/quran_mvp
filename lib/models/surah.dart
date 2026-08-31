import 'ayah.dart';

/// مدل سوره (Surah Model)
/// Represents a Surah (Chapter) of the Quran
class Surah {
  final int number; // شماره ترتیبی سوره (1-114)
  final String name; // نام سوره به عربی
  final String nameAr; // نام عربی (اختیاری)
  final String? nameFa; // نام فارسی (اختیاری)
  final List<Ayah> ayahs; // لیست آیات سوره
  final String type; // نوع سوره: 'مکی' یا 'مدنی' (Makki or Madani)
  final int verseCount; // تعداد آیات
  final int? juz; // جزء قرآنی (Optional)
  final int? page; // شماره صفحه (Optional)
  
  Surah({
    required this.number,
    required this.name,
    this.nameAr = '',
    this.nameFa,
    required this.ayahs,
    this.type = 'مکی',
    int? verseCount,
    this.juz,
    this.page,
  }) : verseCount = verseCount ?? ayahs.length;

  factory Surah.fromJson(Map<String, dynamic> json) {
    final ayahsJson = (json['ayahs'] as List<dynamic>?) ?? [];
    final ayahs = ayahsJson
        .map((a) => Ayah.fromJson(a as Map<String, dynamic>))
        .toList();
    
    return Surah(
      number: json['number'] as int? ?? 0,
      name: (json['name'] ?? '') as String,
      nameAr: (json['nameAr'] ?? json['name'] ?? '') as String,
      nameFa: (json['nameFa'] ?? json['name_fa']) as String?,
      ayahs: ayahs,
      type: (json['type'] ?? 'مکی') as String,
      verseCount: (json['verseCount'] ?? json['verse_count'] ?? ayahs.length) as int,
      juz: json['juz'] as int?,
      page: json['page'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'number': number,
    'name': name,
    'nameAr': nameAr,
    'nameFa': nameFa,
    'ayahs': ayahs.map((a) => a.toJson()).toList(),
    'type': type,
    'verseCount': verseCount,
    'juz': juz,
    'page': page,
  };

  /// دریافت نام محل نزول به فارسی
  /// Get revelation place in Persian
  String get revelationPlace {
    return type == 'مدنی' ? 'مدنی' : 'مکی';
  }

  /// دریافت توصیف سوره برای نمایش در کارت
  /// Get description for card display (e.g., "مکی · ۷ آیه")
  String get displayInfo {
    return '$revelationPlace · $verseCount آیه';
  }
}
