import 'package:flutter/material.dart';
import 'package:gradient_text_generator/widgets.dart';

class ColoursPage extends StatelessWidget {
  const ColoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: StyledText(
            'ADD COLOURS',
            fontSize: 40,
          ),
        ),
        Expanded(
          flex: 4,
          child: StyledText(
            'GRIDVIEW OF COLOURS',
            fontSize: 40,
          ),
        ),
      ],
    );
  }
}