import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../services/quran_service.dart';
import '../widgets/surah_list_item.dart';
import '../widgets/search_bar_widget.dart';
import 'surah_detail_screen.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  late Future<List<Surah>> _surahsFuture;
  final TextEditingController _searchController = TextEditingController();
  List<Surah> _allSurahs = [];
  List<Surah> _filteredSurahs = [];

  @override
  void initState() {
    super.initState();
    _surahsFuture = QuranService().getSurahs();
  }

  void _filterSurahs(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSurahs = _allSurahs;
      } else {
        _filteredSurahs = _allSurahs
            .where((surah) =>
                surah.name.contains(query) ||
                surah.displayInfo.contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
      future: _surahsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'خطا در بارگذاری داده‌ها: ${snapshot.error}',
              textDirection: TextDirection.rtl,
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        _allSurahs = snapshot.data!;
        if (_filteredSurahs.isEmpty && _searchController.text.isEmpty) {
          _filteredSurahs = _allSurahs;
        }

        if (_allSurahs.isEmpty) {
          return const Center(
            child: Text(
              'هیچ سوره‌ای پیدا نشد.',
              textDirection: TextDirection.rtl,
            ),
          );
        }

        return Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SearchBarWidget(
                controller: _searchController,
                hintText: 'جستجو در قرآن...',
                onChanged: _filterSurahs,
              ),
            ),

            // Section Header "سوره‌ها"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'سوره‌ها',
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),

            // Surah List - استفاده از SurahListItem
            Expanded(
              child: _filteredSurahs.isEmpty
                  ? Center(
                      child: Text(
                        'نتیجه‌ای یافت نشد',
                        textDirection: TextDirection.rtl,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: _filteredSurahs.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 1,
                        thickness: 0.5,
                        indent: 0,
                        endIndent: 0,
                      ),
                      itemBuilder: (context, index) {
                        final surah = _filteredSurahs[index];
                        return SurahListItem(
                          surah: surah,
                          index: surah.number,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    SurahDetailScreen(surah: surah),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
