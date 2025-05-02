import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gradient_text_generator/databasing/provider.dart';
import 'package:provider/provider.dart';

class StyledText extends StatelessWidget {
  final String text;
  final bool bold;
  final bool italicize;
  final double? fontSize;
  final Color? styleColour;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;


  const StyledText(this.text, {
    super.key, 
    this.bold = false, 
    this.italicize = false, 
    this.fontSize,
    this.styleColour,
    this.strutStyle, 
    this.textAlign,
    this.textDirection,
    this.locale, 
    this.softWrap, 
    this.overflow, 
    this.textScaler, 
    this.maxLines,
    this.semanticsLabel, 
    this.textWidthBasis, 
    this.textHeightBehavior, 
    this.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,

      // Setting the style of the text (bold + italic) and default font
      style: TextStyle(
        color: styleColour,
        fontSize: fontSize,
        fontFamily: 'AnonymousPro',
        fontWeight: bold? FontWeight.bold: FontWeight.normal,
        fontStyle: italicize? FontStyle.italic: FontStyle.normal,
      ),
      
      // Other options in normal text widget
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}

class LetterInputDialog extends StatefulWidget {
  final String? inputLetter;

  const LetterInputDialog({super.key, this.inputLetter});

  @override
  State<LetterInputDialog> createState() => _LetterInputDialogState();
}

class _LetterInputDialogState extends State<LetterInputDialog> {
  late Color pickerColour;
  late String character;
  late TextEditingController _colourController;
  late TextEditingController _characterController;

  @override
  void initState() {

    character = widget.inputLetter?? '';

    pickerColour = Color(0x00000000);

    if(character != '') {
       _loadColour();
    } 

    _colourController = TextEditingController();
    _characterController = TextEditingController(text: character);

    super.initState();
  }
  @override
  void dispose() {
    _colourController.dispose;
    _characterController.dispose;
    super.dispose();
  }

  void _loadColour() async {
    List<double> colours = await Provider.of<ProviderService>(context, listen: false).getColour(character);
    pickerColour = Color.from(alpha: 1.0, red: colours[0], green: colours[1], blue: colours[2]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StyledText('character:', bold: true,),
              SizedBox(
                width: 50,
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      character = value;
                    });
                    _characterController.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: _characterController.value.text.length
                    );
                  },
                  onTap: (){
                    _characterController.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: _characterController.value.text.length
                    );
                  },
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  controller: _characterController,
        
                  style: TextStyle(
                      fontFamily: 'AnonymousPro',
                      fontSize: 30,
                  ),
        
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(),
                      counterText: ''
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            children: [
              ColorPicker(
                pickerColor: pickerColour,
                onColorChanged: (Color colour){
                  setState(() {
                    pickerColour = colour;
                  });
                },
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
                displayThumbColor: true,
                paletteType: PaletteType.hsvWithHue,
                labelTypes: const [],
                pickerAreaBorderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
                hexInputController: _colourController,
                portraitOnly: true,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: CupertinoTextField(
                  controller: _colourController,
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.tag),
                  ),
                  autofocus: true,
                  maxLength: 9,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: character == ''? null: (){
                Provider.of<ProviderService>(context, listen: false).insertData(
                    character, pickerColour.r, pickerColour.g,pickerColour.b);
                Navigator.of(context).pop();
              },
              child: StyledText('confirm')
            )
          ],
        ),
      ],
    );
  }
}
