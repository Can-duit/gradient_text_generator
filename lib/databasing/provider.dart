import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text_generator/databasing/database.dart';

class ProviderService extends ChangeNotifier{

  List<LetterModel> letterItem = [];

  List<List<Color>> _colourList = [];
  List<List<Color>> get colourList => _colourList;

  List<String> _lines = [];
  List<String> get lines => _lines;

  String _search = '';
  String get search => _search;

  String _inputText = '';
  String get inputText =>_inputText;

  Future<void> getColourList(List<String> text) async {
    if(text.isNotEmpty) {
      _colourList = [];
      
      for (int i = 0; i < text.length; i++){

        var chars = [];
        text[i].split('').forEach((ch) => chars.add(ch));
        bool firstLetter = true;
        Color firstColour = Color(0xFFFFFFFF);
        List<Color> localColourList = [];

        for (int i = 0; i < chars.length; i++) {
          List<double> colourCode = await getColour(chars[i]);
          //List<double> colourCode = [Random().nextDouble(),Random().nextDouble(),Random().nextDouble()];

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
            between = Color.lerp(localColourList[(i*2)-1], finalColour, 0.5) ?? Color(0xFFFFFFFF);
            if((chars[i] == ' ')|| (chars[i] == '\t')){
              firstLetter = true;
            }
          }

          //TODO check for enters to add another text field thing sort of
          //TODO ALSO make it so spaces are "colourless"

          localColourList.add(between);
          localColourList.add(finalColour);
          if(i==chars.length-1){
            localColourList.add(primary);
          }
        }
        _colourList.add(localColourList);
      }
    }
  }

  Future<List<Color>> getTitleColours(String text) async {
    List<Color> titleColours = [];
    var chars = [];
    text.split('').forEach((ch) => chars.add(ch));
    bool firstLetter = true;
    Color firstColour = Color(0xFFFFFFFF);

    for (int i = 0; i < chars.length; i++) {
      List<double> colourCode = await getColour(chars[i]);
      //List<double> colourCode = [Random().nextDouble(),Random().nextDouble(),Random().nextDouble()];

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
        between = Color.lerp(titleColours[(i*2)-1], primary, 0.5) ?? Color(0xFFFFFFFF);
        if((chars[i] == ' ')|| (chars[i] == '\t')){
          firstLetter = true;
        }
      }

      //TODO check for enters to add another text field thing sort of

      titleColours.add(between);
      titleColours.add(finalColour);
      if(i==chars.length-1){
        titleColours.add(primary);
      }
    }
    return titleColours;
  }

  Future<void> setSearch(String searchText, bool notify) async {
    _search = searchText;
    notify? notifyListeners(): null;
    if(searchText == ''){
      print('searched for all');
    }
  }

  Future<void> getSearchedData(String search) async {
    final dataList = await CharacterDatabase.selectFromDatabase(
        CharacterDatabase.tableName, search);
    print('got ${dataList.length} items');
    if (dataList.isNotEmpty){
      print("converting to model");
      List<LetterModel> letterModels = dataList.map((e) => LetterModel.fromDbMap(e)).toList(); 
      letterItem = letterModels;
    }
    print("got datalist");
  }

  Future insertData(String letter, double r, double g, double b) async {
    final newLetter = LetterModel(letter: letter, r: r, g: g, b: b);

    CharacterDatabase.insertData(CharacterDatabase.tableName,{
      'letter': newLetter.letter,
      'r': newLetter.r,
      'g': newLetter.g,
      'b': newLetter.b,
    });
    notifyListeners();
  }

  Future<List<double>> getColour(String letter) async {
    return CharacterDatabase.getColourData(
        CharacterDatabase.tableName, letter);
  }

  Future<void> sendInputText (String input, List<String> textLines) async {
    _inputText = input;
    _lines = textLines;
    
    notifyListeners();
  } 
}