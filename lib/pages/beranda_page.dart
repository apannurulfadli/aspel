import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/custom_card.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda Aspel')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=800'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Selamat Datang di Asrama!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.polmanBlue),
              ),
              const SizedBox(height: 16),
              const CustomCard(
                title: 'Pengumuman Terbaru',
                content: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('- Rapat rutin penghuni asrama hari Jumat pukul 19.00 WIB.'),
                      SizedBox(height: 4),
                      Text('- Jadwal piket kebersihan ruang bersama harap diperhatikan.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const CustomCard(
                title: 'Jam Operasional',
                content: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('- Resepsionis: Senin - Jumat (08.00 - 17.00 WIB)'),
                      SizedBox(height: 4),
                      Text('- Ruang belajar: Setiap hari (06.00 - 22.00 WIB)'),
                      SizedBox(height: 4),
                      Text('- Laundry: Senin, Rabu, Jumat (09.00 - 16.00 WIB)'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const CustomCard(
                title: 'Tata Tertib',
                content: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('- Jam malam pukul 22.00 WIB'),
                      SizedBox(height: 4),
                      Text('- Dilarang membawa tamu tanpa izin pengelola'),
                      SizedBox(height: 4),
                      Text('- Wajib menjaga kebersihan area bersama'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const CustomCard(
                title: 'Kontak Darurat',
                content: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('- Pengelola Asrama: 0812-3456-7890'),
                      SizedBox(height: 4),
                      Text('- Security 24 Jam: 0821-9876-5432'),
                      SizedBox(height: 4),
                      Text('- Klinik Kesehatan: 0813-1122-3344'),
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
