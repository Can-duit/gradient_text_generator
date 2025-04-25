import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class LetterDatabase {
  static const tableName = 'letter_database';

  static Future<Database> letterDatabase()  async {
    final databaseDirPath = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();

    return await openDatabase(
      join(databaseDirPath, "letter_database.db"),
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

  static Future<List<LetterModel>> selectFromDatabase(
      String table, String search) async {
    final db = await LetterDatabase.letterDatabase();
    List<Map<String, dynamic>> maps;

    if (search == ''){
      maps = await db.rawQuery('''SELECT * FROM $tableName
      ORDER BY letter
      ''');
      if (maps.isNotEmpty){
        return maps.map((map) => LetterModel.fromDbMap(map)).toList();
      }
      return [];
    }
    
    maps = await db.rawQuery('''SELECT * FROM $tableName
    WHERE letter = ?
    ORDER BY letter''', ['%$search']);

    if (maps.isNotEmpty){
      return maps.map((map) => LetterModel.fromDbMap(map)).toList();
    }
    return [];
  }

  static Future insertData(String table, Map<String, Object> data) async {
    final db = await LetterDatabase.letterDatabase();
    print(table);
    print(data);
    return db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<double>> getColourData(
      String table, String letter) async {
    final db = await LetterDatabase.letterDatabase();

    final result = await db
        .rawQuery('SELECT * FROM $table WHERE letter=?', [letter]);

    print("query - - - - - - - - - - - - - - - - - - - -:");
    print(result);


    if (result.isEmpty){
      return [Random().nextDouble(), Random().nextDouble(), Random().nextDouble()];
    }

    LetterModel letterModel = result.map((e) => LetterModel.fromDbMap(e)).first;

    List<double> data = letterModel.getRGB();

    print(letter);
    print(data);
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
      : letter = map['letter'],
        r = map['r'],
        g = map['g'],
        b = map['b'];

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