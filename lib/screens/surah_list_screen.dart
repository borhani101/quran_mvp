import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../services/quran_service.dart';
import '../widgets/surah_card.dart';
import 'surah_detail_screen.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  late Future<List<Surah>> _surahsFuture;

  @override
  void initState() {
    super.initState();
    _surahsFuture = QuranService().getSurahs();
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
        final surahs = snapshot.data!;
        if (surahs.isEmpty) {
          return const Center(
            child: Text(
              'هیچ سوره‌ای پیدا نشد.',
              textDirection: TextDirection.rtl,
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: surahs.length,
          itemBuilder: (context, index) {
            final s = surahs[index];
            return SurahCard(
              surah: s,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SurahDetailScreen(surah: s),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
