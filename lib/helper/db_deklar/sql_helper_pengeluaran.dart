import 'package:deklarasi/utils/setOpt.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperPengeluaran {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE pengeluaran(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        idsurat INTEGER,
        deskripsi TEXT,
        jumlah INTEGER,
        kategori TEXT,
        nota TEXT,
        tglpengeluaran TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbpengeluaran.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create
  static Future<int> createItem(int? idsurat, String deskripsi, int? jumlah,
      String? tglpengeluaran, String? kategori, String? nota) async {
    final db = await SQLHelperPengeluaran.db();

    final data = {
      'idsurat': idsurat,
      'deskripsi': deskripsi,
      'jumlah': jumlah,
      'tglpengeluaran': tglpengeluaran,
      'kategori': kategori,
      'nota': nota
    };
    final id = await db.insert('pengeluaran', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //multiple create
  static Future<int> multipleCreate(int? idsurat, List data) async {
    final db = await SQLHelperPengeluaran.db();

    String sql = '''
INSERT INTO pengeluaran (
    idsurat,
    deskripsi,
    jumlah,
    tglpengeluaran,
    kategori,
    nota
  ) VALUES (?, ?, ?, ?, ?, ?)
''';
//and then loop your data here
    for (var i = 0; i < data.length; i++) {
      await db.rawInsert(sql, [
        idsurat,
        data[i]['deskripsi'],
        int.parse(data[i]['jml']),
        data[i]['tgl'],
        SetOpt.defkategori(data[i]['kelompok']),
        SetOpt.defNota(data[i]['nota'])
      ]);
    }

    return 0;
  }

  // Read
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperPengeluaran.db();
    return db.query('pengeluaran', orderBy: "id DESC");
  }

  // Read by id surat
  static Future<List<Map<String, dynamic>>> getItemBySurat(int id) async {
    final db = await SQLHelperPengeluaran.db();
    return db.query('pengeluaran',
        orderBy: "id DESC", where: "idsurat = ?", whereArgs: [id]);
  }

  // Read by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperPengeluaran.db();
    return db.query('pengeluaran', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Sum
  static Future getItemSum(int id) async {
    final db = await SQLHelperPengeluaran.db();
    var result = await db.rawQuery(
        "SELECT SUM(jumlah) as Total FROM pengeluaran where idsurat = $id");
    var value = result[0]['Total'];
    return value;
  }

  // Update by id
  static Future<int> updateItem(int id, String deskripsi, int? jumlah,
      String? tglpengeluaran, String? kategori, String? nota) async {
    final db = await SQLHelperPengeluaran.db();

    final data = {
      'deskripsi': deskripsi,
      'jumlah': jumlah,
      'tglpengeluaran': tglpengeluaran,
      'kategori': kategori,
      'nota': nota,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('pengeluaran', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperPengeluaran.db();
    try {
      await db.delete("pengeluaran", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // Delete by surat
  static Future<void> deleteItemBySurat(int id) async {
    final db = await SQLHelperPengeluaran.db();
    try {
      await db.delete("pengeluaran", where: "idsurat = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // Delete all
  static Future<void> deleteAll() async {
    final db = await SQLHelperPengeluaran.db();
    try {
      await db.delete("pengeluaran");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
