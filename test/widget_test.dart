import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aspel/models/laporan.dart';
import 'package:aspel/pages/profil_page.dart';
import 'package:aspel/pages/splash_screen.dart';
import 'package:aspel/widgets/app_drawer.dart';

void main() {
  testWidgets('SplashScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

    expect(find.text('Aspel'), findsOneWidget);
    expect(find.text('Asrama Polman Babel'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('ProfilPage displays academic info and icons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfilPage()));

    expect(find.text('Profil Saya'), findsOneWidget);
    expect(find.text('Apan Nurul Fadli'), findsOneWidget);
    expect(find.text('1062532'), findsWidgets);
    expect(find.text('Program Studi'), findsOneWidget);
    expect(find.text('Teknologi Rekayasa Perangkat Lunak'), findsOneWidget);
    expect(find.text('Instansi'), findsOneWidget);
    expect(find.text('Politeknik Manufaktur Negeri Bangka Belitung'),
        findsOneWidget);

    expect(find.byIcon(Icons.badge_outlined), findsWidgets);
    expect(find.byIcon(Icons.school_outlined), findsOneWidget);
    expect(find.byIcon(Icons.class_outlined), findsOneWidget);
    expect(find.byIcon(Icons.account_balance_outlined), findsOneWidget);
  });

  testWidgets('AppDrawer displays profile & menu items',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          drawer: AppDrawer(),
          body: Center(child: Text('Test Body')),
        ),
      ),
    );

    final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    // Verify Drawer Header
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is CircleAvatar &&
            widget.backgroundImage is AssetImage &&
            (widget.backgroundImage! as AssetImage).assetName ==
                'assets/images/Profile.jpg',
      ),
      findsOneWidget,
    );
    expect(find.text('Apan Nurul Fadli'), findsOneWidget);
    expect(find.text('1062532'), findsOneWidget);

    // Verify Drawer Menu items
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Lapor Masalah'), findsOneWidget);
    expect(find.text('Riwayat Laporan'), findsOneWidget);
    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    expect(find.byIcon(Icons.edit_note_outlined), findsOneWidget);
    expect(find.byIcon(Icons.assignment_outlined), findsOneWidget);
  });

  test('Laporan model serialization toDbMap and fromDbMap', () {
    final now = DateTime.now();
    final item = Laporan(
      id: 1,
      kamar: 'A102',
      kategori: 'Kebersihan',
      deskripsi: 'Tempat sampah penuh di lorong lantai 1',
      isDone: false,
      createdAt: now,
    );

    final map = item.toDbMap();
    expect(map['kamar'], 'A102');
    expect(map['kategori'], 'Kebersihan');
    expect(map['is_done'], 0);

    final fromMap = Laporan.fromDbMap(map);
    expect(fromMap.kamar, 'A102');
    expect(fromMap.kategori, 'Kebersihan');
    expect(fromMap.isDone, false);
  });

  test('Laporan validators follow the PRD rules after trimming', () {
    expect(Laporan.validateKamar('   '), isNotNull);
    expect(Laporan.validateKamar(' A102 '), isNull);
    expect(Laporan.validateDeskripsi('1234567890'), isNotNull);
    expect(Laporan.validateDeskripsi('12345678901'), isNull);
    expect(Laporan.validateDeskripsi('  1234567890  '), isNotNull);
  });
}
