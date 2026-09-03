import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../models/ayah.dart';
import '../services/quran_service.dart';
import '../theme/app_colors.dart';
import 'surah_detail_screen.dart';

class SearchResultItem {
  final Surah surah;
  final Ayah ayah;
  final int ayahIndex;

  SearchResultItem({
    required this.surah,
    required this.ayah,
    required this.ayahIndex,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResultItem> _results = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  Future<void> _performSearch(String query) async {
    final cleanQuery = query.trim().toLowerCase();

    if (cleanQuery.isEmpty) {
      if (!mounted) return;
      setState(() {
        _results = [];
        _hasSearched = false;
        _isLoading = false;
      });
      return;
    }

    if (mounted) {
      setState(() {
        _isLoading = true;
        _hasSearched = true;
      });
    }

    try {
      final surahs = await QuranService.instance.loadSurahs();
      final results = <SearchResultItem>[];

      for (final surah in surahs) {
        for (var i = 0; i < surah.ayahs.length; i++) {
          final ayah = surah.ayahs[i];

          final arabicText = ayah.textAr.toLowerCase();
          final translationText = ayah.textFa.toLowerCase();

          if (arabicText.contains(cleanQuery) ||
              translationText.contains(cleanQuery)) {
            results.add(
              SearchResultItem(
                surah: surah,
                ayah: ayah,
                ayahIndex: i,
              ),
            );
          }
        }
      }

      if (!mounted) return;
      setState(() {
        _results = results;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _results = [];
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا در بارگذاری اطلاعات: $error'),
        ),
      );
    }
  }

  String _toPersianNumber(dynamic number) {
    if (number == null) return '';
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return number.toString().split('').map((char) {
      final index = int.tryParse(char);
      return index != null ? persianDigits[index] : char;
    }).join('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white, fontFamily: 'IRANSans'),
          cursorColor: AppColors.goldAccent,
          decoration: const InputDecoration(
            hintText: 'جستجو در متن آیات و ترجمه...',
            hintStyle: TextStyle(color: Colors.white70, fontFamily: 'IRANSans'),
            border: InputBorder.none,
          ),
          onSubmitted: _performSearch,
          textInputAction: TextInputAction.search,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => _performSearch(_searchController.text),
          ),
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                _searchController.clear();
                _performSearch('');
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(color: AppColors.primaryMedium),
      )
          : !_hasSearched
          ? const Center(
        child: Text(
          'کلمه یا عبارت مورد نظر خود را جستجو کنید',
          style: TextStyle(color: AppColors.textGrey, fontFamily: 'IRANSans'),
        ),
      )
          : _results.isEmpty
          ? const Center(
        child: Text(
          'نتیجه‌ای یافت نشد',
          style: TextStyle(color: AppColors.textGrey, fontFamily: 'IRANSans'),
        ),
      )
          : ListView.builder(
        itemCount: _results.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final item = _results[index];
          final String surahTitle =
          (item.surah.nameFa != null && item.surah.nameFa!.isNotEmpty)
              ? item.surah.nameFa!
              : item.surah.nameAr;

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),
            color: AppColors.cardBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: AppColors.dividerColor,
                width: 0.8,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'سوره $surahTitle - آیه ${_toPersianNumber(item.ayah.number)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.primaryMedium,
                      fontFamily: 'IRANSans',
                    ),
                  ),
                  Text(
                    item.surah.nameAr,
                    style: const TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 16,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      item.ayah.textAr,
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 16,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.ayah.textFa,
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textGrey,
                        fontFamily: 'IRANSans',
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurahDetailScreen(
                      surah: item.surah,
                      initialAyahIndex: item.ayahIndex,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
