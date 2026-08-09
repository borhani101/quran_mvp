import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../services/quran_service.dart';
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
          return Center(child: Text('خطا در بارگذاری داده‌ها: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final surahs = snapshot.data!;
        if (surahs.isEmpty) {
          return const Center(child: Text('هیچ سوره‌ای پیدا نشد.'));
        }
        return ListView.separated(
          itemCount: surahs.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, index) {
            final s = surahs[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SurahDetailScreen(surah: s),
                ));
              },
              title: Text(
                s.name,
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Text(
                '${s.number}',
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          },
        );
      },
    );
  }
}
