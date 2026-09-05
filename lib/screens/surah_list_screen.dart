import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../services/quran_service.dart';
import '../theme/app_colors.dart';
import '../widgets/surah_list_item.dart';
import 'surah_detail_screen.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({Key? key}) : super(key: key);

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  late Future<List<Surah>> _surahsFuture;
  List<Surah> _allSurahs = [];
  List<Surah> _filteredSurahs = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _surahsFuture = QuranService.instance.loadSurahs();
  }

  void _filterSurahs(String query) {
    if (query.trim().isEmpty) {
      setState(() => _filteredSurahs = _allSurahs);
      return;
    }
    setState(() {
      _filteredSurahs = _allSurahs.where((s) {
        final q = query.trim().toLowerCase();
        return s.name.toLowerCase().contains(q) ||
            s.number.toString().contains(q);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.bgCream,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),
              // هدر بسم الله
              const Center(
                child: Text(
                  'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // نوار جستجو
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.goldAccent.withValues(alpha: 0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterSurahs,
                    style: const TextStyle(
                      fontFamily: 'NotoNaskhArabic',
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: 'جستجوی سوره...',
                      hintStyle: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: 13,
                        color: Colors.grey.shade400,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.primaryGreen,
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // جداکننده عنوان سوره‌ها
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 18,
                      decoration: BoxDecoration(
                        color: AppColors.goldAccent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'سوره‌ها',
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // لیست سوره‌ها
              Expanded(
                child: FutureBuilder<List<Surah>>(
                  future: _surahsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryGreen,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'خطا در بارگذاری اطلاعات: ${snapshot.error}',
                          style: const TextStyle(fontFamily: 'NotoNaskhArabic'),
                        ),
                      );
                    }

                    if (_allSurahs.isEmpty && snapshot.hasData) {
                      _allSurahs = snapshot.data!;
                      if (_searchController.text.isEmpty) {
                        _filteredSurahs = _allSurahs;
                      }
                    }

                    if (_filteredSurahs.isEmpty) {
                      return const Center(
                        child: Text(
                          'موردی یافت نشد',
                          style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: _filteredSurahs.length,
                      padding: const EdgeInsets.only(bottom: 24),
                      itemBuilder: (context, index) {
                        final surah = _filteredSurahs[index];
                        return SurahListItem(
                          surah: surah,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    SurahDetailScreen(surah: surah),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
