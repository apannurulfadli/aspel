class Laporan {
  static const List<String> kategoriList = [
    'Kerusakan Fasilitas',
    'Kebersihan',
    'Keamanan',
  ];
  static String get defaultKategori => kategoriList.first;

  static String? validateKamar(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor kamar tidak boleh kosong';
    }
    return null;
  }

  static String? validateDeskripsi(String? value) {
    if (value == null || value.trim().length <= 10) {
      return 'Deskripsi harus lebih dari 10 karakter';
    }
    return null;
  }

  final int? id;
  final String kamar;
  final String kategori;
  final String deskripsi;
  final bool isDone;
  final DateTime createdAt;

  Laporan({
    this.id,
    required this.kamar,
    required this.kategori,
    required this.deskripsi,
    this.isDone = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Laporan copyWith({
    int? id,
    String? kamar,
    String? kategori,
    String? deskripsi,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return Laporan(
      id: id ?? this.id,
      kamar: kamar ?? this.kamar,
      kategori: kategori ?? this.kategori,
      deskripsi: deskripsi ?? this.deskripsi,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, Object?> toDbMap() => {
        'id': id,
        'kamar': kamar,
        'kategori': kategori,
        'deskripsi': deskripsi,
        'is_done': isDone ? 1 : 0,
        'created_at': createdAt.millisecondsSinceEpoch,
      };

  static Laporan fromDbMap(Map<String, Object?> map) {
    return Laporan(
      id: map['id'] as int?,
      kamar: map['kamar'] as String,
      kategori: map['kategori'] as String,
      deskripsi: map['deskripsi'] as String,
      isDone: (map['is_done'] as int? ?? 0) == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['created_at'] as int? ?? DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }
}
