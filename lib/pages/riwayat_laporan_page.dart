import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../database/laporan_db.dart';
import '../models/laporan.dart';

class RiwayatLaporanPage extends StatefulWidget {
  const RiwayatLaporanPage({super.key});

  @override
  State<RiwayatLaporanPage> createState() => _RiwayatLaporanPageState();
}

class _RiwayatLaporanPageState extends State<RiwayatLaporanPage> {
  late Future<List<Laporan>> _futureLaporan;

  @override
  void initState() {
    super.initState();
    _futureLaporan = LaporanDb.instance.all();
  }

  void _reload() {
    setState(() {
      _futureLaporan = LaporanDb.instance.all();
    });
  }

  Future<void> _addOrEditLaporan({Laporan? laporan}) async {
    final kamarController = TextEditingController(text: laporan?.kamar ?? '');
    final deskripsiController =
        TextEditingController(text: laporan?.deskripsi ?? '');
    String selectedKategori = laporan?.kategori ?? Laporan.defaultKategori;
    final formKey = GlobalKey<FormState>();

    try {
      final result = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                  top: 24,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    AppColors.polmanBlue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                laporan == null
                                    ? Icons.add_circle_outline
                                    : Icons.edit_note,
                                color: AppColors.polmanBlue,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                laporan == null
                                    ? 'Tambah Laporan Baru'
                                    : 'Edit Laporan',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.polmanBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: kamarController,
                          decoration: InputDecoration(
                            labelText: 'Nomor Kamar',
                            hintText: 'Contoh: A102',
                            prefixIcon: const Icon(Icons.meeting_room_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: Laporan.validateKamar,
                        ),
                        const SizedBox(height: 14),
                        DropdownButtonFormField<String>(
                          initialValue: selectedKategori,
                          decoration: InputDecoration(
                            labelText: 'Kategori Laporan',
                            prefixIcon: const Icon(Icons.category_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: Laporan.kategoriList.map((kat) {
                            return DropdownMenuItem(
                              value: kat,
                              child: Text(kat),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setModalState(() {
                                selectedKategori = val;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: deskripsiController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Deskripsi Masalah',
                            hintText: 'Jelaskan keluhan Anda...',
                            prefixIcon: const Icon(Icons.description_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: Laporan.validateDeskripsi,
                        ),
                        const SizedBox(height: 20),
                        FilledButton.icon(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pop(context, true);
                            }
                          },
                          icon: const Icon(Icons.check_circle_outline),
                          label: const Text('Simpan'),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.polmanBlue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );

      if (result != true || !mounted) return;

      if (laporan == null) {
        await LaporanDb.instance.insert(
          Laporan(
            kamar: kamarController.text.trim(),
            kategori: selectedKategori,
            deskripsi: deskripsiController.text.trim(),
          ),
        );
      } else {
        await LaporanDb.instance.update(
          laporan.copyWith(
            kamar: kamarController.text.trim(),
            kategori: selectedKategori,
            deskripsi: deskripsiController.text.trim(),
          ),
        );
      }
    } finally {
      kamarController.dispose();
      deskripsiController.dispose();
    }

    if (!mounted) return;
    _reload();
  }

  Future<void> _deleteLaporan(Laporan laporan) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.delete_outline,
            color: Colors.red.shade400,
            size: 32,
          ),
        ),
        title: const Text('Hapus Laporan?', textAlign: TextAlign.center),
        content: Text(
          'Yakin ingin menghapus laporan kamar "${laporan.kamar}"?',
          textAlign: TextAlign.center,
        ),
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context, false),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (ok != true) return;
    await LaporanDb.instance.delete(laporan.id!);
    if (!mounted) return;
    _reload();
  }

  Future<void> _toggleDone(Laporan laporan) async {
    await LaporanDb.instance.toggleDone(laporan);
    if (!mounted) return;
    _reload();
  }

  Widget _buildLaporanCard(Laporan l) {
    return _LaporanCard(
      laporan: l,
      onToggle: () => _toggleDone(l),
      onEdit: () => _addOrEditLaporan(laporan: l),
      onDelete: () => _deleteLaporan(l),
    );
  }

  List<Widget> _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<Laporan> items,
  }) {
    if (items.isEmpty) return const [];
    return [
      _SectionHeader(
        title: title,
        icon: icon,
        color: color,
      ),
      const SizedBox(height: 12),
      ...items.map(_buildLaporanCard),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Laporan (CRUD)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _reload,
            tooltip: 'Segarkan',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addOrEditLaporan(),
        backgroundColor: AppColors.polmanBlue,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Laporan'),
      ),
      body: FutureBuilder<List<Laporan>>(
        future: _futureLaporan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final list = snapshot.data ?? [];
          if (list.isEmpty) {
            return const _EmptyState();
          }

          final pendingList = list.where((l) => !l.isDone).toList();
          final completedList = list.where((l) => l.isDone).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ..._buildSection(
                title: 'Dalam Proses / Belum Selesai',
                icon: Icons.pending_actions,
                color: Colors.orange,
                items: pendingList,
              ),
              if (pendingList.isNotEmpty && completedList.isNotEmpty)
                const SizedBox(height: 16),
              ..._buildSection(
                title: 'Selesai / Teratasi',
                icon: Icons.check_circle_outline,
                color: Colors.green,
                items: completedList,
              ),
              const SizedBox(height: 80),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _SectionHeader({
    required this.title,
    required this.icon,
    this.color = AppColors.polmanBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _LaporanCard extends StatelessWidget {
  final Laporan laporan;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _LaporanCard({
    required this.laporan,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: laporan.isDone ? Colors.grey.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: laporan.isDone
              ? Colors.grey.shade300
              : AppColors.polmanBlue.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: laporan.isDone
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: laporan.isDone,
              activeColor: Colors.green,
              visualDensity: VisualDensity.compact,
              onChanged: (_) => onToggle(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      _Badge(
                        label: 'Kamar ${laporan.kamar}',
                        backgroundColor:
                            AppColors.polmanBlue.withValues(alpha: 0.1),
                        textColor: AppColors.polmanBlue,
                      ),
                      _Badge(
                        label: laporan.kategori,
                        backgroundColor: Colors.amber.shade50,
                        textColor: Colors.amber.shade900,
                        border: Border.all(
                            color: Colors.amber.shade300, width: 0.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    laporan.deskripsi,
                    style: TextStyle(
                      fontSize: 14,
                      decoration:
                          laporan.isDone ? TextDecoration.lineThrough : null,
                      color: laporan.isDone
                          ? AppColors.polmanSilver
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 13,
                        color: AppColors.polmanSilver,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(laporan.createdAt),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.polmanSilver,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ActionButton(
                  icon: Icons.edit_outlined,
                  color: AppColors.polmanBlue,
                  tooltip: 'Edit',
                  onPressed: onEdit,
                ),
                _ActionButton(
                  icon: Icons.delete_outline,
                  color: Colors.red,
                  tooltip: 'Hapus',
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) {
      final h = date.hour.toString().padLeft(2, '0');
      final m = date.minute.toString().padLeft(2, '0');
      return 'Hari ini $h:$m';
    } else if (diff.inDays == 1) {
      return 'Kemarin';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} hari lalu';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.polmanBlue.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.assignment_turned_in_outlined,
                size: 72,
                color: AppColors.polmanBlue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Belum Ada Laporan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Klik tombol "Tambah Laporan" di bawah\nuntuk membuat catatan keluhan baru',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.polmanSilver,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Border? border;

  const _Badge({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
        border: border,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(),
      icon: Icon(icon, color: color, size: 20),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}
