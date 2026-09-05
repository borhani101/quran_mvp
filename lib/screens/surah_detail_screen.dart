import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/surah.dart';
import '../widgets/ayah_tile.dart';
import '../theme/app_colors.dart';

/// صفحه جزئیات سوره — می‌تواند روی آیه مشخصی اسکرول کند
class SurahDetailScreen extends StatefulWidget {
  final Surah surah;
  final int? initialAyahIndex;

  const SurahDetailScreen({super.key, required this.surah, this.initialAyahIndex});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  final Map<int, GlobalKey> _ayahKeys = {};
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    /// ایجاد کلید برای هر آیه
    for (var i = 0; i < widget.surah.ayahs.length; i++) {
      _ayahKeys[i] = GlobalKey();
    }

    /// بعد از ریندر اولیه، اگر آیتم اولیه خواسته شده است، به آن اسکرول کن
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialAyahIndex != null) {
        _scrollToAyah(widget.initialAyahIndex!);
      }
    });
  }

  Future<void> _scrollToAyah(int index) async {
    final key = _ayahKeys[index];
    if (key == null) return;
    final ctx = key.currentContext;
    if (ctx != null) {
      await Scrollable.ensureVisible(ctx, alignment: 0.12, duration: const Duration(milliseconds: 300));
    } else {
      /// محاسبه حدودی
      final offset = (index * 120).toDouble();
      _scrollController.animateTo(offset.clamp(0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final surah = widget.surah;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// طرح چپ
            SvgPicture.asset(
              'lib/assets/ornament_left.svg',
              width: 18,
              height: 22,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            
            /// نام سوره و شماره
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    surah.name,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'سوره ${surah.number}',
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            
            /// طرح راست
            SvgPicture.asset(
              'lib/assets/ornament_right.svg',
              width: 18,
              height: 22,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: surah.ayahs.length,
        itemBuilder: (context, index) {
          final ayah = surah.ayahs[index];
          return Container(
            key: _ayahKeys[index],
            child: AyahTile(
              ayah: ayah,
              onTap: () {
                /// تپ روی آیه
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('سوره ${surah.name} — آیه ${ayah.number}', textDirection: TextDirection.rtl),
                    duration: const Duration(milliseconds: 800),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
