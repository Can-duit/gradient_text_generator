import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class CharacterDatabase {
  static const tableName = 'synesthesic_text_database';

  static Future<Database> letterDatabase()  async {
    final databaseDirPath = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();

    return await openDatabase(
      join(databaseDirPath, "synesthesic_text_db.db"),
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE $tableName (
        letter STRING NOT NULL PRIMARY KEY,
        r DOUBLE NOT NULL,
        g DOUBLE NOT NULL,
        b DOUBLE NOT NULL
        )
        ''');
      },
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>>> selectFromDatabase(
      String table, String search) async {
    final db = await CharacterDatabase.letterDatabase();

    final result = await db.rawQuery('''SELECT * FROM $tableName
    WHERE NOT letter = ? AND 
    letter LIKE ?
    ORDER BY letter''', [' ','%$search%']);

    return result;
  }

  static Future insertData(String table, Map<String, Object> data) async {
    final db = await CharacterDatabase.letterDatabase();
    return db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<double>> getColourData(
      String table, String letter) async {
    final db = await CharacterDatabase.letterDatabase();
    final result = await db
        .rawQuery('SELECT * FROM $table WHERE letter=?', [letter]);

    if (result.isEmpty){
      double r = Random().nextDouble();
      double g = Random().nextDouble();
      double b = Random().nextDouble();

      final newLetter = LetterModel(letter: letter, r: r, g: g, b: b);

      insertData(CharacterDatabase.tableName,{
        'letter': newLetter.letter,
        'r': newLetter.r,
        'g': newLetter.g,
        'b': newLetter.b,
      });
      
      return [r, g, b];
    }

    LetterModel letterModel = result.map((e) => LetterModel.fromDbMap(e)).first;

    List<double> data = letterModel.getRGB();

    return data;
  }
}


class LetterModel {
  String letter;
  double r, g, b;

  LetterModel({
    required this.letter,
    required this.r,
    required this.g,
    required this.b
  });
  LetterModel.fromDbMap(Map<String, dynamic> map)
      : letter = map['letter'] as String,
        r = map['r'] as double,
        g = map['g'] as double,
        b = map['b'] as double;

  Map<String, dynamic> toDbMap() {
    var map = Map<String, dynamic>();
    map['letter'] = letter;
    map['r'] = r;
    map['g'] = g;
    map['b'] = b;
    return map;
  }

  List<double> getRGB (){
    return [r, g, b];
  }
}