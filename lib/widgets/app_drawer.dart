import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../pages/beranda_page.dart';
import '../pages/fasilitas_page.dart';
import '../pages/laporan_page.dart';
import '../pages/profil_page.dart';
import '../pages/riwayat_laporan_page.dart';

class AppDrawer extends StatelessWidget {
  final ValueChanged<int>? onSelectTab;

  const AppDrawer({super.key, this.onSelectTab});

  void _navigateToTab(BuildContext context, int tabIndex, Widget fallbackPage) {
    Navigator.pop(context);
    if (onSelectTab != null) {
      onSelectTab!(tabIndex);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => fallbackPage),
      );
    }
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
      leading: Icon(
        icon,
        size: 24,
        color: AppColors.textPrimary,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AppColors.polmanBlue,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 28,
              left: 24,
              right: 24,
              bottom: 28,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/Profile.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  'Apan Nurul Fadli',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '1062532',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.home_outlined,
                  title: 'Beranda',
                  onTap: () => _navigateToTab(
                    context,
                    0,
                    BerandaPage(onNavigateToTab: onSelectTab),
                  ),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.apartment_outlined,
                  title: 'Fasilitas Asrama',
                  onTap: () => _navigateToTab(
                    context,
                    1,
                    const FasilitasPage(),
                  ),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.edit_note_outlined,
                  title: 'Lapor Masalah',
                  onTap: () => _navigateToTab(
                    context,
                    2,
                    const LaporanPage(),
                  ),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.assignment_outlined,
                  title: 'Riwayat Laporan',
                  onTap: () => _navigateToPage(
                    context,
                    const RiwayatLaporanPage(),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Divider(height: 1),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'Profil Saya',
                  onTap: () => _navigateToTab(
                    context,
                    3,
                    const ProfilPage(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
