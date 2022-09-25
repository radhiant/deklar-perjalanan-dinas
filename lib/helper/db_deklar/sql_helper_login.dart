import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperLogin {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE akun(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nik TEXT,
        namalkp TEXT,
        nama TEXT,
        unit TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dblogin.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item
  static Future<int> createItem(
      String nik, String? namalkp, String? nama, String? unit) async {
    final db = await SQLHelperLogin.db();

    final data = {'nik': nik, 'namalkp': namalkp, 'nama': nama, 'unit': unit};
    final id = await db.insert('akun', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperLogin.db();
    return db.query('akun', orderBy: "id DESC");
  }

  // Delete
  static Future<void> deleteAll() async {
    final db = await SQLHelperLogin.db();
    try {
      await db.delete("akun");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
