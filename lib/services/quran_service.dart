import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/surah.dart';
import '../models/ayah.dart';

class QuranService {
  static final QuranService instance = QuranService._internal();

  factory QuranService() => instance;

  QuranService._internal();

  List<Surah>? _surahsCache;

  Future<List<Surah>> loadSurahs() async {
    if (_surahsCache != null) {
      return _surahsCache!;
    }

    final jsonString =
    await rootBundle.loadString('assets/data/quran.json');

    // فایل JSON شما یک Map است که لیست در کلید 'surahs' قرار دارد
    final Map<String, dynamic> decodedData = json.decode(jsonString);
    final List<dynamic> jsonList = decodedData['surahs'] as List<dynamic>;

    _surahsCache = jsonList
        .map((json) => Surah.fromJson(json as Map<String, dynamic>))
        .toList();

    return _surahsCache!;
  }

  // برای سازگاری با کدهای قبلی
  Future<List<Surah>> getSurahs() async {
    return loadSurahs();
  }

  Future<Surah?> getSurahByNumber(int number) async {
    final surahs = await loadSurahs();

    try {
      return surahs.firstWhere(
            (surah) => surah.number == number,
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<SearchResult>> search(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    final surahs = await loadSurahs();
    final List<SearchResult> results = [];

    final cleanQuery = query.trim().toLowerCase();

    for (final surah in surahs) {
      for (int i = 0; i < surah.ayahs.length; i++) {
        final ayah = surah.ayahs[i];

        if (ayah.textAr.contains(cleanQuery) ||
            ayah.textFa.toLowerCase().contains(cleanQuery)) {
          results.add(
            SearchResult(
              surah: surah,
              ayah: ayah,
              ayahIndex: i,
            ),
          );
        }
      }
    }

    return results;
  }
}

class SearchResult {
  final Surah surah;
  final Ayah ayah;
  final int ayahIndex;

  SearchResult({
    required this.surah,
    required this.ayah,
    required this.ayahIndex,
  });
}
