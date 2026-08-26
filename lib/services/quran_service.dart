import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/surah.dart';
import '../models/ayah.dart';

// یک سرویس ساده برای بارگذاری و جستجو روی داده‌های محلی قرآن
class QuranService {
  QuranService._privateConstructor();
  static final QuranService _instance = QuranService._privateConstructor();
  factory QuranService() => _instance;

  List<Surah>? _surahsCache;

  Future<List<Surah>> loadSurahs() async {
    if (_surahsCache != null) return _surahsCache!;
    try {
      final raw = await rootBundle.loadString('assets/data/quran.json');
      final Map<String, dynamic> data = json.decode(raw) as Map<String, dynamic>;
      final surahList = (data['surahs'] as List<dynamic>).map((s) => Surah.fromJson(s as Map<String, dynamic>)).toList();
      _surahsCache = surahList;
      return surahList;
    } catch (e) {
      // در صورت خطا، لیست خالی بازگردانده می‌شود تا UI خطا را نمایش دهد
      rethrow;
    }
  }

  Future<List<Surah>> getSurahs() => loadSurahs();

  Future<Surah?> getSurahByNumber(int number) async {
    final list = await loadSurahs();
    try {
      return list.firstWhere((s) => s.number == number);
    } catch (_) {
      return null;
    }
  }

  // نتیجه جستجو: نگه داشتن مرجع سوره و آیه
  Future<List<_SearchResult>> search(String query) async {
    final q = query.trim();
    if (q.isEmpty) return [];
    final lower = q.toLowerCase();
    final list = await loadSurahs();
    final results = <_SearchResult>[];
    for (final surah in list) {
      for (var i = 0; i < surah.ayahs.length; i++) {
        final ayah = surah.ayahs[i];
        final ar = ayah.textAr.toLowerCase();
        final fa = ayah.textFa.toLowerCase();
        if (ar.contains(lower) || fa.contains(lower)) {
          results.add(_SearchResult(surah: surah, ayah: ayah, ayahIndex: i));
        }
      }
    }
    return results;
  }
}

// کلاس داخلی نتیجه جستجو
class _SearchResult {
  final Surah surah;
  final Ayah ayah;
  final int ayahIndex; // index در لیست آیات (صفر مبنا)

  _SearchResult({
    required this.surah,
    required this.ayah,
    required this.ayahIndex,
  });
}
