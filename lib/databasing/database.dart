import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class LetterDatabase {
  static const tableName = 'letter_data';

  static Future<Database> letterDatabase()  async {
    final databaseDirPath = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();

    return await openDatabase(
      join(databaseDirPath, "letter_db.db"),
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE $tableName (
        letter STRING NOT NULL PRIMARY KEY,
        colour STRING NOT NULL
        )
        ''');
      },
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>>> selectFromDatabase(String search) async {
    final db = await LetterDatabase.letterDatabase();

    if (search == ''){
      return db.rawQuery('''SELECT * FROM $tableName
      ORDER BY letter
      ''');
    }
    
    return db.rawQuery('''SELECT * FROM $tableName
    WHERE letter = ?
    ORDER BY letter''', ['%$search']);
  }

  static Future insertData(Map<String, Object> data) async {
    final db = await LetterDatabase.letterDatabase();
    return db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  
}