import 'package:flutter/material.dart';

import '../models/surah.dart';
import '../services/bookmark_service.dart';
import '../services/quran_service.dart';
import '../theme/app_colors.dart';
import 'surah_detail_screen.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  late Future<List<Bookmark>> _bookmarksFuture;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  void _loadBookmarks() {
    _bookmarksFuture = BookmarkService.getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('نشان‌شده‌ها'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Bookmark>>(
        future: _bookmarksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'خطا در بارگذاری نشان‌شده‌ها: ${snapshot.error}',
                style: const TextStyle(
                  fontFamily: 'Vazirmatn',
                ),
              ),
            );
          }

          final bookmarks = snapshot.data ?? [];

          if (bookmarks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border_rounded,
                    size: 64,
                    color: AppColors.textLight.withValues(
                      alpha: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'هنوز آیه‌ای را نشان نکرده‌اید',
                    style: TextStyle(
                      fontFamily: 'Vazirmatn',
                      fontSize: 16,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            itemCount: bookmarks.length,
            separatorBuilder: (_, __) =>
            const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final bookmark = bookmarks[index];

              return Dismissible(
                key: ValueKey(
                  '${bookmark.surahNumber}_${bookmark.ayahNumber}',
                ),
                direction: DismissDirection.endToStart,

                background: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),

                onDismissed: (_) async {
                  await BookmarkService.removeBookmark(
                    surahNumber: bookmark.surahNumber,
                    ayahNumber: bookmark.ayahNumber,
                  );

                  if (mounted) {
                    setState(() {
                      _loadBookmarks();
                    });
                  }
                },

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.04,
                        ),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),

                    title: Text(
                      'سوره ${bookmark.surahName} - آیه ${bookmark.ayahNumber}',
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontFamily: 'Vazirmatn',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textDark,
                      ),
                    ),

                    subtitle: bookmark.ayahText.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.only(
                        top: 6,
                      ),
                      child: Text(
                        bookmark.ayahText,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 16,
                          color:
                          AppColors.primaryMedium,
                        ),
                      ),
                    )
                        : null,

                    trailing: const Icon(
                      Icons.chevron_left,
                      color: AppColors.textLight,
                    ),

                    onTap: () async {
                      final Surah? surah =
                      await QuranService()
                          .getSurahByNumber(
                        bookmark.surahNumber,
                      );

                      if (surah != null &&
                          context.mounted) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                SurahDetailScreen(
                                  surah: surah,
                                  initialAyahIndex:
                                  bookmark.ayahNumber - 1,
                                ),
                          ),
                        );

                        if (mounted) {
                          setState(() {
                            _loadBookmarks();
                          });
                        }
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}