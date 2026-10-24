import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  static const List<Map<String, dynamic>> _academicInfo = [
    {
      'icon': Icons.badge_outlined,
      'label': 'NIM',
      'value': '1062532',
    },
    {
      'icon': Icons.school_outlined,
      'label': 'Program Studi',
      'value': 'Teknologi Rekayasa Perangkat Lunak',
    },
    {
      'icon': Icons.class_outlined,
      'label': 'Kelas',
      'value': '2 TRPL B',
    },
    {
      'icon': Icons.account_balance_outlined,
      'label': 'Instansi',
      'value': 'Politeknik Manufaktur Negeri Bangka Belitung',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Saya')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 65,
                  backgroundColor: AppColors.polmanSilver,
                  backgroundImage: AssetImage('assets/images/Profile.jpg'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Apan Nurul Fadli',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.polmanBlue,
                  ),
                ),
                const SizedBox(height: 6),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.badge_outlined, size: 18, color: AppColors.polmanBlue),
                    SizedBox(width: 6),
                    Text(
                      'NIM: 1062532',
                      style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Informasi Akademik',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.polmanBlue,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 8),
                        ..._academicInfo.map(
                          (item) => _buildInfoTile(
                            icon: item['icon'] as IconData,
                            label: item['label'] as String,
                            value: item['value'] as String,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0x1A394F7A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.polmanBlue, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.polmanSilver,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
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
