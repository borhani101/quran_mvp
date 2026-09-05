import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            /// طرح اسلیمی سمت راست
            SvgPicture.asset(
              'lib/assets/ornament_right.svg',
              width: 24,
              height: 28,
              colorFilter: const ColorFilter.mode(
                AppColors.goldAccent,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            
            /// تایتل اصلی
            const Text(
              'قرآن طبق تنزیل',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            
            /// طرح اسلیمی سمت چپ
            SvgPicture.asset(
              'lib/assets/ornament_left.svg',
              width: 24,
              height: 28,
              colorFilter: const ColorFilter.mode(
                AppColors.goldAccent,
                BlendMode.srcIn,
              ),
            ),
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
