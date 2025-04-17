import 'package:flutter/material.dart';

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

