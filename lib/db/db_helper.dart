import 'package:flutter_diaries/models/diaries.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE diary (
  ${NoteTable.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${NoteTable.image} TEXT NOT NULL,
  ${NoteTable.title} TEXT NOT NULL,
  ${NoteTable.story} TEXT NOT NULL
)
''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<List<Map<String, dynamic>>> getAllDiariesRaw() async {
    final db = await instance.database;
    return await db.rawQuery('SELECT * FROM diary');
  }

  insertData() async {
    final db = await instance.database;
    return await db.rawQuery('''INSERT INTO diary (_id, image, title, story)
VALUES (1, 'example.jpg', 'Example Title', 'This is a sample story');
''');
  }
}
