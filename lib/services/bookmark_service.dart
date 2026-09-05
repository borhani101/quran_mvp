import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService {
  static const String _bookmarkKey = 'bookmarked_ayahs';

  static Future<List<String>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_bookmarkKey) ?? [];
  }

  static Future<bool> isBookmarked([int? surahId, int? ayahId]) async {
    if (surahId == null || ayahId == null) return false;
    final bookmarks = await getBookmarks();
    return bookmarks.contains('$surahId:$ayahId');
  }

  static Future<void> addBookmark([int? surahId, int? ayahId]) async {
    if (surahId == null || ayahId == null) return;
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    final key = '$surahId:$ayahId';
    if (!bookmarks.contains(key)) {
      bookmarks.add(key);
      await prefs.setStringList(_bookmarkKey, bookmarks);
    }
  }

  static Future<void> removeBookmark([int? surahId, int? ayahId]) async {
    if (surahId == null || ayahId == null) return;
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    final key = '$surahId:$ayahId';
    if (bookmarks.contains(key)) {
      bookmarks.remove(key);
      await prefs.setStringList(_bookmarkKey, bookmarks);
    }
  }

  static Future<bool> toggleBookmark(int surahId, int ayahId) async {
    final isMarked = await isBookmarked(surahId, ayahId);
    if (isMarked) {
      await removeBookmark(surahId, ayahId);
      return false;
    } else {
      await addBookmark(surahId, ayahId);
      return true;
    }
  }
}