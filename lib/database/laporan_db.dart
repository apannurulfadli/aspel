import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import '../models/laporan.dart';

class LaporanDb {
  static final LaporanDb instance = LaporanDb._internal();
  LaporanDb._internal();

  Database? _db;

  Future<Database> get _database async {
    if (_db != null) return _db!;

    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    _db = await openDatabase(
      'laporan_sqlite.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE laporan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            kamar TEXT NOT NULL,
            kategori TEXT NOT NULL,
            deskripsi TEXT NOT NULL,
            is_done INTEGER NOT NULL DEFAULT 0,
            created_at INTEGER NOT NULL
          );
        ''');
        await db.execute('''
          CREATE INDEX idx_laporan_done_created ON laporan(is_done, created_at DESC);
        ''');
      },
    );

    return _db!;
  }

  Future<List<Laporan>> all() async {
    final db = await _database;
    final rows = await db.query(
      'laporan',
      orderBy: 'is_done ASC, created_at DESC',
    );
    return rows.map(Laporan.fromDbMap).toList();
  }

  Future<int> insert(Laporan laporan) async {
    final db = await _database;
    return await db.insert('laporan', laporan.toDbMap()..remove('id'));
  }

  Future<void> update(Laporan laporan) async {
    if (laporan.id == null) return;
    final db = await _database;
    await db.update(
      'laporan',
      laporan.toDbMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [laporan.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await _database;
    await db.delete('laporan', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> toggleDone(Laporan laporan) async {
    if (laporan.id == null) return;
    final db = await _database;
    await db.update(
      'laporan',
      {'is_done': laporan.isDone ? 0 : 1},
      where: 'id = ?',
      whereArgs: [laporan.id],
    );
  }
}
