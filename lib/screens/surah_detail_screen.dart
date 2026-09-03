import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../theme/app_colors.dart';
import '../widgets/ayah_tile.dart';

class SurahDetailScreen extends StatefulWidget {
  final Surah surah;
  final int? initialAyahIndex;

  const SurahDetailScreen({
    super.key,
    required this.surah,
    this.initialAyahIndex,
  });

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  final Map<int, GlobalKey> _ayahKeys = {};
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.surah.ayahs.length; i++) {
      _ayahKeys[i] = GlobalKey();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialAyahIndex != null) {
        _scrollToAyah(widget.initialAyahIndex!);
      }
    });
  }

  void _scrollToAyah(int index) {
    final key = _ayahKeys[index];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
      appBar: AppBar(
        title: Text(widget.surah.name),
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: widget.surah.ayahs.length,
        itemBuilder: (context, index) {
          final ayah = widget.surah.ayahs[index];
          return AyahTile(
            key: _ayahKeys[index],
            ayah: ayah,
            surahNumber: widget.surah.number,
            surahName: widget.surah.name,
            ayahIndex: index,
            isHighlighted: index == widget.initialAyahIndex,
          );
        },
      ),
    );
  }
}
