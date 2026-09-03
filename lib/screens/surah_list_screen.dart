import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../services/quran_service.dart';
import '../widgets/surah_list_item.dart';
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
    // اصلاح متد فراخوانی سرویس
    _surahsFuture = QuranService.instance.loadSurahs();
  }

  void _filterSurahs(String query) {
    setState(() {
      final cleanQuery = query.trim().toLowerCase();
      if (cleanQuery.isEmpty) {
        _filteredSurahs = _allSurahs;
      } else {
        _filteredSurahs = _allSurahs.where((surah) {
          final nameMatch = surah.name.toLowerCase().contains(cleanQuery);
          final nameArMatch = surah.nameAr.toLowerCase().contains(cleanQuery);
          final nameFaMatch = surah.nameFa != null &&
              surah.nameFa!.toLowerCase().contains(cleanQuery);
          final infoMatch = surah.displayInfo.toLowerCase().contains(cleanQuery);

          return nameMatch || nameArMatch || nameFaMatch || infoMatch;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color creamBackground = Color(0xFFFBF8F1);
    const Color goldColor = Color(0xFFC7A265);
    const Color primaryGreen = Color(0xFF1E3A2F);

    return Container(
      color: creamBackground,
      child: FutureBuilder<List<Surah>>(
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
            return const Center(
              child: CircularProgressIndicator(color: goldColor),
            );
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
              // نوار جستجو
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterSurahs,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'جستجو در نام سوره‌ها...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 22,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),

              // سربرگ «سوره‌ها»
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 6),
                child: Column(
                  children: [
                    const Text(
                      'سوره‌ها',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 48,
                      height: 2.5,
                      decoration: BoxDecoration(
                        color: goldColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),

              // لیست سوره‌ها
              Expanded(
                child: _filteredSurahs.isEmpty
                    ? Center(
                  child: Text(
                    'نتیجه‌ای یافت نشد',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.only(top: 6, bottom: 16),
                  itemCount: _filteredSurahs.length,
                  itemBuilder: (context, index) {
                    final surah = _filteredSurahs[index];
                    return SurahListItem(
                      surah: surah,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SurahDetailScreen(surah: surah),
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
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
