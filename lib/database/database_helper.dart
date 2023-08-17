import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:wiseki/model/note.dart';

class DatabaseTable {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('CREATE TABLE notes ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'title STRING, description TEXT,');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('drus', version: 1, onCreate: (
      sql.Database database,
      int version,
    ) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(Notes notes) async {
    final db = await DatabaseTable.db();
    final id = await db.insert('notes', notes.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

   static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseTable.db();
    return db.query('notes', orderBy: 'id');
  }

  static Future<void> delete(int id) async {
    final db = await DatabaseTable.db();
    try {
      db.delete('notes', where: 'id =?', whereArgs: [id]);
    } catch (e) {
      debugPrint('$e');
    }
  }
}


