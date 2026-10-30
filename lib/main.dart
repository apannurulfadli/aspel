import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/app_colors.dart';
import 'pages/splash_screen.dart';

// Inisialisasi DB ditangani sepenuhnya oleh LaporanDb (laporan_db.dart)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AspelApp());
}

class AspelApp extends StatelessWidget {
  const AspelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aspel Polman Babel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.polmanBlue,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.polmanBlue,
          foregroundColor: Colors.white,
          elevation: 1,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: AppColors.polmanBlue,
          unselectedItemColor: AppColors.polmanSilver,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
