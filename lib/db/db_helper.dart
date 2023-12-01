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
    _database = null;
  }

  Future<List<Map<String, dynamic>>> getAllDiariesRaw() async {
    final db = await instance.database;
    return await db.rawQuery('SELECT * FROM diary');
  }

  insertData() async {
    final db = await instance.database;
    return await db.rawQuery('''INSERT INTO diary ( image, title, story)
VALUES ( '/Users/pond/Library/Developer/CoreSimulator/Devices/67809B79-A15B-4F35-B7D6-4E0370BB713E/data/Containers/Data/Application/11E0103D-6F4C-4B82-982A-BCB36FCEEF5C/tmp/image_picker_3DBD3EF0-8DD7-4CB2-872A-207260535534-78935-000000F3CBAF57E3.jpg', 'Example Title3', 'This is a sample story');
''');
  }

  insertDataViaForm(String image,String title , String story) async {
    final db = await instance.database;
    return await db.rawQuery('''INSERT INTO diary ( image, title, story)
VALUES ( '$image', '$title', '$story');
''');
  }


  Future deleteAllDiaries() async {
    final db = await instance.database;
    await db.delete('diary');
  }

 
}
