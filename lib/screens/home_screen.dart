import 'package:flutter/material.dart';
import 'surah_list_screen.dart';
import 'search_screen.dart';

// صفحه اصلی با نوار پایین (tab-like) دو تب: سوره‌ها و جستجو
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
    // Directionality در سطح اپ تنظیم شده در main.dart؛ باز هم RTL را رعایت می‌کنیم
    return Scaffold(
      appBar: AppBar(
        title: const Text('قرآن کریم', textDirection: TextDirection.rtl),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        useLegacyColorScheme: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'سوره‌ها',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'جستجو',
          ),
        ],
      ),
    );
  }
}
