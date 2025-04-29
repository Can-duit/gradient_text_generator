import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text_generator/databasing/database.dart';

class ProviderService extends ChangeNotifier{

  List<LetterModel> letterItem = [];

  List<Color> colourList = [];

  String _search = '';
  String get search => _search;

  Future<void> getColourList(String text) async {
    if(text.isNotEmpty) {
      colourList = [];
      var chars = [];
      text.split('').forEach((ch) => chars.add(ch));
      bool firstLetter = true;
      Color firstColour = Color(0xFFFFFFFF);

      for (int i = 0; i < chars.length; i++) {
        print("First for");
        List<double> colourCode = await getColour(chars[i]);
        //List<double> colourCode = [Random().nextDouble(),Random().nextDouble(),Random().nextDouble()];
        print(colourCode);

        Color between;
        Color finalColour;
        Color primary = Color.from(
            alpha: 1.0,
            red: colourCode[0],
            green: colourCode[1],
            blue: colourCode[2]
        );

        if (firstLetter){
          between = primary;
          finalColour = primary;
          firstColour = primary;
          firstLetter = false;
        } else{
          finalColour = Color.lerp(primary, firstColour, 0.4) ?? Color(0xFFFFFFFF);
          between = Color.lerp(colourList[(i*2)-1], primary, 0.5) ?? Color(0xFFFFFFFF);
          if((chars[i] == ' ')|| (chars[i] == '\t')){
            firstLetter = true;
          }
        }

        //TODO check for enters to add another text field thing sort of

        colourList.add(between);
        colourList.add(finalColour);
        if(i==chars.length-1){
          colourList.add(primary);
        }
      }
    }
  }

  Future<void> setSearch(String searchText) async {
    _search = searchText;
  }

  Future<void> getSearchedData(String search) async {
    final dataList = await CharacterDatabase.selectFromDatabase(
        CharacterDatabase.tableName, search);

    letterItem = dataList;
    notifyListeners();
  }

  Future insertData(String letter, double r, double g, double b) async {
    final newLetter = LetterModel(letter: letter, r: r, g: g, b: b);

    CharacterDatabase.insertData(CharacterDatabase.tableName,{
      'letter': newLetter.letter,
      'r': newLetter.r,
      'g': newLetter.g,
      'b': newLetter.b,
    });
    print(letter);
    print(r);
    print(g);
    print(b);
    notifyListeners();
  }

  Future<List<double>> getColour(String letter) async {
    return CharacterDatabase.getColourData(
        CharacterDatabase.tableName, letter);
  }
}