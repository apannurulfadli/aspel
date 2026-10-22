import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  final _formKey = GlobalKey<FormState>();
  final _kamarController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String? _kategori = 'Kerusakan Fasilitas';

  void _submitLaporan() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Laporan Berhasil!'),
          content: const Text('Keluhan Anda telah terkirim ke pengelola asrama.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _kamarController.clear();
                _deskripsiController.clear();
                setState(() {
                  _kategori = 'Kerusakan Fasilitas';
                });
              },
              child: const Text('Tutup'),
            )
          ],
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
              const Text('Sampaikan keluhan atau masalah terkait asrama di sini.', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _kamarController,
                decoration: const InputDecoration(labelText: 'Nomor Kamar', border: OutlineInputBorder()),
                validator: (value) => (value == null || value.isEmpty) ? 'Nomor kamar tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _kategori,
                decoration: const InputDecoration(labelText: 'Kategori Laporan', border: OutlineInputBorder()),
                items: ['Kerusakan Fasilitas', 'Kebersihan', 'Keamanan'].map((String val) {
                  return DropdownMenuItem(value: val, child: Text(val));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _kategori = val;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _deskripsiController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Deskripsi Masalah', border: OutlineInputBorder()),
                validator: (value) => (value == null || value.length < 10) ? 'Deskripsi minimal 10 karakter' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.polmanBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _submitLaporan,
                  child: const Text('Kirim Laporan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
