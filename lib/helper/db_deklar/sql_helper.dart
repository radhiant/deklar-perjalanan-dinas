import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE surat(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        judulsurat TEXT,
        anggaran INTEGER,
        tglsurat TEXT,
        idkaryawan INTEGER,
        ttlp INTEGER,
        jmld INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbdeklar.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String judulsurat, String? anggaran,
      String? tglsurat, int idkaryawan) async {
    final db = await SQLHelper.db();

    final data = {
      'judulsurat': judulsurat,
      'anggaran': anggaran,
      'tglsurat': tglsurat,
      'idkaryawan': idkaryawan,
      'ttlp': int.parse("0"),
      'jmld': int.parse("0"),
    };
    final id = await db.insert('surat', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('surat', orderBy: "id DESC");
  }

  // Read by id surat
  static Future<List<Map<String, dynamic>>> getItemByKaryawan(int id) async {
    final db = await SQLHelper.db();
    return db.query('surat',
        orderBy: "id DESC", where: "idkaryawan = ?", whereArgs: [id]);
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('surat', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String judulsurat, int? anggaran, String? tglsurat) async {
    final db = await SQLHelper.db();

    final data = {
      'judulsurat': judulsurat,
      'anggaran': anggaran,
      'tglsurat': tglsurat,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('surat', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Update total & jumlah
  static Future<int> updateTotalPengeluaran(int id, int ttlp, int? jmld) async {
    final db = await SQLHelper.db();

    final data = {
      'ttlp': ttlp,
      'jmld': jmld,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('surat', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("surat", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // Delete
  static Future<void> deleteAll() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("surat");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
