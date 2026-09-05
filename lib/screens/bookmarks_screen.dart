import 'package:flutter/material.dart';
import '../services/bookmark_service.dart';
import '../services/quran_service.dart';
import '../models/ayah.dart';
import '../models/surah.dart';
import '../widgets/ayah_tile.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  late Future<List<Map<String, dynamic>>> _bookmarksFuture;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  void _loadBookmarks() {
    _bookmarksFuture = _fetchBookmarkedAyahs();
  }

  Future<List<Map<String, dynamic>>> _fetchBookmarkedAyahs() async {
    final bookmarkKeys = await BookmarkService.getBookmarks();
    final List<Map<String, dynamic>> results = [];
    
    // فراخوانی نمونه به جای دسترسی استاتیک
    final allSurahs = await QuranService().getSurahs();

    for (var key in bookmarkKeys) {
      final parts = key.split(':');
      if (parts.length == 2) {
        final surahNumber = int.tryParse(parts[0]);
        final ayahNumber = int.tryParse(parts[1]);

        if (surahNumber != null && ayahNumber != null) {
          try {
            final surah = allSurahs.firstWhere((s) => s.number == surahNumber);
            final ayah = surah.ayahs.firstWhere((a) => a.number == ayahNumber);
            results.add({'surah': surah, 'ayah': ayah});
          } catch (_) {}
        }
      }
    }
    return results;
  }

  void _removeBookmark(int surahNumber, int ayahNumber) async {
    await BookmarkService.removeBookmark(surahNumber, ayahNumber);
    setState(() {
      _loadBookmarks();
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('از لیست نشانه‌ها حذف شد')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _bookmarksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'هیچ آیه‌ای نشانه‌گذاری نشده است',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final surah = items[index]['surah'] as Surah;
              final ayah = items[index]['ayah'] as Ayah;

              return Dismissible(
                key: Key('${surah.number}:${ayah.number}'),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  _removeBookmark(surah.number, ayah.number);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'سوره ${surah.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    AyahTile(
                      ayah: ayah,
                      surahNumber: surah.number,
                      surahName: surah.name,
                      isBookmarked: true,
                      onBookmarkToggle: () => _removeBookmark(surah.number, ayah.number),
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}