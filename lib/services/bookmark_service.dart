import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LastReadModel {
  final int surahNumber;
  final String surahName;
  final int ayahIndex;

  LastReadModel({
    required this.surahNumber,
    required this.surahName,
    required this.ayahIndex,
  });

  Map<String, dynamic> toJson() => {
    'surahNumber': surahNumber,
    'surahName': surahName,
    'ayahIndex': ayahIndex,
  };

  factory LastReadModel.fromJson(Map<String, dynamic> json) {
    return LastReadModel(
      surahNumber: json['surahNumber'] as int,
      surahName: json['surahName'] as String,
      ayahIndex: json['ayahIndex'] as int,
    );
  }
}

class Bookmark {
  final int surahNumber;
  final String surahName;
  final int ayahNumber;
  final String ayahText;

  Bookmark({
    required this.surahNumber,
    required this.surahName,
    required this.ayahNumber,
    required this.ayahText,
  });

  Map<String, dynamic> toJson() => {
    'surahNumber': surahNumber,
    'surahName': surahName,
    'ayahNumber': ayahNumber,
    'ayahText': ayahText,
  };

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      surahNumber: json['surahNumber'] as int,
      surahName: json['surahName'] as String,
      ayahNumber: json['ayahNumber'] as int,
      ayahText: (json['ayahText'] as String?) ?? '',
    );
  }
}

class BookmarkService {
  static const String _bookmarksKey = 'user_bookmarks';
  static const String _lastReadKey = 'user_last_read';

  static Future<void> saveLastRead({
    required int surahNumber,
    required String surahName,
    required int ayahIndex,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final model = LastReadModel(
      surahNumber: surahNumber,
      surahName: surahName,
      ayahIndex: ayahIndex,
    );

    await prefs.setString(
      _lastReadKey,
      json.encode(model.toJson()),
    );
  }

  static Future<LastReadModel?> getLastRead() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(_lastReadKey);

    if (data == null) {
      return null;
    }

    try {
      return LastReadModel.fromJson(
        json.decode(data) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }

  static Future<List<Bookmark>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> list =
        prefs.getStringList(_bookmarksKey) ?? [];

    return list
        .map(
          (item) => Bookmark.fromJson(
        json.decode(item) as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  static Future<void> addBookmark(
      Bookmark bookmark,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> list =
        prefs.getStringList(_bookmarksKey) ?? [];

    list.removeWhere((item) {
      final b = Bookmark.fromJson(
        json.decode(item) as Map<String, dynamic>,
      );

      return b.surahNumber == bookmark.surahNumber &&
          b.ayahNumber == bookmark.ayahNumber;
    });

    list.add(
      json.encode(bookmark.toJson()),
    );

    await prefs.setStringList(
      _bookmarksKey,
      list,
    );
  }

  static Future<void> removeBookmark({
    required int surahNumber,
    required int ayahNumber,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> list =
        prefs.getStringList(_bookmarksKey) ?? [];

    list.removeWhere((item) {
      final b = Bookmark.fromJson(
        json.decode(item) as Map<String, dynamic>,
      );

      return b.surahNumber == surahNumber &&
          b.ayahNumber == ayahNumber;
    });

    await prefs.setStringList(
      _bookmarksKey,
      list,
    );
  }

  static Future<bool> isBookmarked({
    required int surahNumber,
    required int ayahNumber,
  }) async {
    final bookmarks = await getBookmarks();

    return bookmarks.any(
          (b) =>
      b.surahNumber == surahNumber &&
          b.ayahNumber == ayahNumber,
    );
  }
}