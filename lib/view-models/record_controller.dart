// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:weight_tracker_app/models/record.dart';

class RecordController {
  static final RecordController instance = RecordController._init();
  static Database? _database;

  RecordController._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('record.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = await getDatabasesPath();
    final dbPath = join(path, filePath);

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Records (
        id $idType,
        dateTime $textType,
        weight $integerType,
        photoUrl TEXT,
        note TEXT
      )
    ''');
  }

  Future<void> addRecord(Record record) async {
    final db = await instance.database;
    await db.insert('Records', record.toMap());
  }

  Future<void> deleteRecord(int id) async {
    final db = await instance.database;
    await db.delete(
      'Records',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateRecord(Record record) async {
    final db = await RecordController.instance.database;
    await db.update(
      'Records',
      record.toMap(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  Future<Record?> getRecordById(Record record) async {
    final db = await RecordController.instance.database;
    final result = await db.query(
      'Records',
      where: 'id = ?',
      whereArgs: [record.id],
    );
    if (result.isNotEmpty) {
      return Record.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<List<Record>> getAllRecords() async {
    final db = await instance.database;
    const orderBy = 'dateTime DESC';
    final result = await db.query('Records', orderBy: orderBy);
    return result.map((map) => Record.fromMap(map)).toList();
  }
}
