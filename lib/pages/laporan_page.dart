import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../database/laporan_db.dart';
import '../models/laporan.dart';
import 'riwayat_laporan_page.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  final _formKey = GlobalKey<FormState>();
  final _kamarController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String _kategori = Laporan.defaultKategori;

  void _resetForm() {
    _kamarController.clear();
    _deskripsiController.clear();
    setState(() {
      _kategori = Laporan.defaultKategori;
    });
  }

  Future<void> _submitLaporan() async {
    if (!_formKey.currentState!.validate()) return;

    await LaporanDb.instance.insert(
      Laporan(
        kamar: _kamarController.text.trim(),
        kategori: _kategori,
        deskripsi: _deskripsiController.text.trim(),
      ),
    );

    if (!mounted) return;

    final lihatRiwayat = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Laporan Berhasil!'),
        content: const Text(
          'Laporan berhasil disimpan di perangkat ini dan dapat dilihat kembali '
          'melalui riwayat laporan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Lihat Riwayat'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );

    if (!mounted) return;
    _resetForm();
    if (lihatRiwayat == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RiwayatLaporanPage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _kamarController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lapor Masalah')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Sampaikan keluhan atau masalah terkait asrama di sini.',
                  style: TextStyle(fontSize: 14)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _kamarController,
                decoration: const InputDecoration(
                    labelText: 'Nomor Kamar', border: OutlineInputBorder()),
                validator: Laporan.validateKamar,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _kategori,
                decoration: const InputDecoration(
                    labelText: 'Kategori Laporan',
                    border: OutlineInputBorder()),
                items: Laporan.kategoriList.map((String val) {
                  return DropdownMenuItem(value: val, child: Text(val));
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _kategori = val;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _deskripsiController,
                maxLines: 4,
                decoration: const InputDecoration(
                    labelText: 'Deskripsi Masalah',
                    border: OutlineInputBorder()),
                validator: Laporan.validateDeskripsi,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.polmanBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _submitLaporan,
                  child: const Text('Kirim Laporan',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
