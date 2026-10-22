import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Saya')),
      body: Center(
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
              const Text('Apan Nurul Fadli', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.polmanBlue)),
              const Text('NIM: 1062532', style: TextStyle(fontSize: 16, color: AppColors.textPrimary)),
              const SizedBox(height: 24),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Informasi Akademik', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.polmanBlue)),
                      Divider(),
                      SizedBox(height: 8),
                      Text('Program Studi:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Teknologi Rekayasa Perangkat Lunak'),
                      SizedBox(height: 12),
                      Text('Kelas:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('2 TRPL B'),
                      SizedBox(height: 12),
                      Text('Instansi:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Politeknik Manufaktur Negeri Bangka Belitung'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
