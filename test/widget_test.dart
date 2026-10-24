import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aspel/pages/profil_page.dart';
import 'package:aspel/pages/splash_screen.dart';

void main() {
  testWidgets('SplashScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

    expect(find.text('Aspel'), findsOneWidget);
    expect(find.text('Asrama Polman Babel'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('ProfilPage displays academic info and icons', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfilPage()));

    expect(find.text('Profil Saya'), findsOneWidget);
    expect(find.text('Apan Nurul Fadli'), findsOneWidget);
    expect(find.text('1062532'), findsWidgets);
    expect(find.text('Program Studi'), findsOneWidget);
    expect(find.text('Teknologi Rekayasa Perangkat Lunak'), findsOneWidget);
    expect(find.text('Instansi'), findsOneWidget);
    expect(find.text('Politeknik Manufaktur Negeri Bangka Belitung'), findsOneWidget);

    expect(find.byIcon(Icons.badge_outlined), findsWidgets);
    expect(find.byIcon(Icons.school_outlined), findsOneWidget);
    expect(find.byIcon(Icons.class_outlined), findsOneWidget);
    expect(find.byIcon(Icons.account_balance_outlined), findsOneWidget);
  });
}
