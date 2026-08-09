import 'package:flutter/material.dart';
import '../services/quran_service.dart';
import '../widgets/ayah_tile.dart';
import 'surah_detail_screen.dart';

// صفحه جستجو
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;
  String _query = '';
  List<_ResultItem> _results = [];

  Future<void> _doSearch(String q) async {
    setState(() {
      _loading = true;
      _query = q;
    });
    try {
      final raw = await QuranService().search(q);
      final mapped = raw.map((r) => _ResultItem(surah: r.surah, ayah: r.ayah, ayahIndex: r.ayahIndex)).toList();
      setState(() {
        _results = mapped;
      });
    } catch (e) {
      // خطای ساده را نمایش می‌دهیم
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطا در جستجو: $e', textDirection: TextDirection.rtl)));
      setState(() {
        _results = [];
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text('برای جستجو متن را وارد کنید', textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Text('نتیجه‌ای یافت نشد', textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: TextField(
            controller: _controller,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'متن عربی یا فارسی را جستجو کنید...',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
              isDense: true,
            ),
            onSubmitted: (v) => _doSearch(v),
            onChanged: (v) {
              // جستجوی فوری ساده
              if (v.trim().isEmpty) {
                setState(() {
                  _results = [];
                  _query = '';
                });
                return;
              }
              // اجرا کردن جستجو
              // برای سادگی بدون debounce
              _doSearch(v);
            },
          ),
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _query.isEmpty
                  ? _buildEmptyState()
                  : _results.isEmpty
                      ? _buildNoResults()
                      : ListView.separated(
                          itemCount: _results.length,
                          separatorBuilder: (_, __) => const Divider(height: 0),
                          itemBuilder: (context, index) {
                            final r = _results[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              onTap: () {
                                // باز کردن صفحه سوره و اسکرول به آیه
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => SurahDetailScreen(
                                    surah: r.surah,
                                    initialAyahIndex: r.ayahIndex,
                                  ),
                                ));
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '${r.surah.name} — آیه ${r.ayah.number}',
                                    textDirection: TextDirection.rtl,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    r.ayah.textAr,
                                    textDirection: TextDirection.rtl,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    r.ayah.textFa,
                                    textDirection: TextDirection.rtl,
                                    style: Theme.of(context).textTheme.bodySmall,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
        ),
      ],
    );
  }
}

class _ResultItem {
  final dynamic surah;
  final dynamic ayah;
  final int ayahIndex;
  _ResultItem({required this.surah, required this.ayah, required this.ayahIndex});
}
