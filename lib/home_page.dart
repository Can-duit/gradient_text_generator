import 'package:flutter/material.dart';
import 'package:gradient_text_generator/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: StyledText(
            'TEXT INPUT AREA',
            fontSize: 40,
          ),
        ),
        Expanded(
          child: StyledText(
            'GENERATE BUTTON',
            fontSize: 40,
          ),
        ),
        Expanded(
          child: StyledText(
            'TEXT DISPLAY',
            fontSize: 40,
          ),
        ),
      ],
    );
  }
}