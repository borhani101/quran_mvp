import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // اپ به طور کامل راست‌به‌چپ است
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'قرآن MVP',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
        // locale: const Locale('fa'), // می‌توانید فعال کنید در صورت نیاز
      ),
    );
  }
}
