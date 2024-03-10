import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DictionaryDB {
  DictionaryDB._();
  static final DictionaryDB db = DictionaryDB._();

  static late Database _database;

  Future<void> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Dictionary.db");
    _database = await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE Word ("
        "id INTEGER PRIMARY KEY,"
        "keys TEXT,"
        "means TEXT,"
        "note TEXT"
        ")"
      );
      await db.execute(
        "CREATE TABLE Grammar ("
        "id INTEGER PRIMARY KEY,"
        "form TEXT,"
        "structure TEXT"
        ")"
      );
    });
  }
}