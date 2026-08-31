import 'package:flutter/material.dart';
import 'surah_list_screen.dart';
import 'search_screen.dart';
import '../theme/app_colors.dart';

/// صفحه اصلی با نوار پایین (tab-like) دو تب: سوره‌ها و جستجو
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    SurahListScreen(),
    SearchScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'قرآن کریم',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            // نشان‌های اسلیمی دو طرف
            const Text('✦', style: TextStyle(color: AppColors.goldAccent, fontSize: 18)),
            const SizedBox(width: 4),
            const Text('✦', style: TextStyle(color: AppColors.goldAccent, fontSize: 18)),
          ],
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        useLegacyColorScheme: false,
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.textGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'قرآن',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'نشان‌ها',
          ),
        ],
      ),
    );
  }
}
