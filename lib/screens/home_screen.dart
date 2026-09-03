import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'bookmarks_screen.dart';
import 'search_screen.dart';
import 'surah_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // کلمه const از اول این لیست حذف شد تا خطای کامپایل برطرف شود
  final List<Widget> _pages = [
    const SurahListScreen(),
    const SearchScreen(),
    const BookmarksScreen(),
  ];

  final List<String> _titles = const [
    'سوره‌ها',
    'جستجو',
    'نشان‌ها',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(
            fontFamily: 'Vazirmatn',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.textGrey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'سوره‌ها',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'جستجو',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_rounded),
            label: 'نشان‌ها',
          ),
        ],
      ),
    );
  }
}
