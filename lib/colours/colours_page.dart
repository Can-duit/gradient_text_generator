import 'package:flutter/material.dart';
import 'package:gradient_text_generator/colours/colours_add.dart';
import 'package:gradient_text_generator/colours/colours_gridview.dart';
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
          child: AddColoursWidget(),
        ),
        Expanded(
          flex: 3,
          child: ColoursGridview(),
        ),
      ],
    );
  }
}