import 'package:flutter/material.dart';
import '../widgets/facility_item.dart';
import 'fasilitas_detail_page.dart';

// Data fasilitas terpusat di satu tempat (hardcoded sesuai PRD)
final List<Map<String, dynamic>> _fasilitasData = [
  {
    'title': 'Kamar Standar',
    'desc': 'Kasur, Meja Belajar, Lemari',
    'imageUrl': 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800',
    'details': [
      'Kasur spring bed ukuran 120x200 cm',
      'Meja belajar dan kursi ergonomis',
      'Lemari 2 pintu dengan kunci',
      'Jendela dengan pemandangan taman',
      'Kapasitas 2 penghuni per kamar',
      'Lantai keramik bersih',
    ],
  },
  {
    'title': 'Ruang Belajar',
    'desc': 'Wi-Fi 24 Jam, Papan Tulis, AC',
    'imageUrl': 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800',
    'details': [
      'Wi-Fi 24 jam kecepatan tinggi',
      'Papan tulis dan proyektor tersedia',
      'AC dengan suhu nyaman',
      'Tersedia 20 meja belajar individu',
      'Jam operasional: 06.00 - 22.00 WIB',
      'Area hening, dilarang berisik',
    ],
  },
  {
    'title': 'Dapur Bersama',
    'desc': 'Kompor Gas, Kulkas, Dispenser',
    'imageUrl': 'https://images.unsplash.com/photo-1556911220-bff31c812dba?w=800',
    'details': [
      'Kompor gas 2 tungku',
      'Kulkas 2 pintu kapasitas besar',
      'Dispenser air panas dan dingin',
      'Area cuci piring dengan air mengalir',
      'Rak penyimpanan peralatan masak',
      'Jadwal piket kebersihan bersama',
    ],
  },
  {
    'title': 'Ruang Olahraga',
    'desc': 'Matras Yoga, Dumbbell, Treadmill',
    'imageUrl': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
    'details': [
      'Matras yoga 6 unit',
      'Dumbbell set 2 kg - 20 kg',
      'Treadmill 2 unit',
      'Cermin penuh di seluruh dinding',
      'Buka setiap hari: 05.00 - 22.00 WIB',
      'Gratis untuk semua penghuni asrama',
    ],
  },
];

class FasilitasPage extends StatelessWidget {
  const FasilitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fasilitas Asrama')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _fasilitasData.length,
        itemBuilder: (context, index) {
          final item = _fasilitasData[index];
          return FacilityItem(
            title: item['title'],
            desc: item['desc'],
            imageUrl: item['imageUrl'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FasilitasDetailPage(
                    title: item['title'],
                    desc: item['desc'],
                    imageUrl: item['imageUrl'],
                    details: List<String>.from(item['details']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
