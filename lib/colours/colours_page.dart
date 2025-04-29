import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gradient_text_generator/colours/colours_add.dart';
import 'package:gradient_text_generator/colours/colours_gridview.dart';

class ColoursPage extends StatelessWidget {
  const ColoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AddColoursWidget(
          searchFunction: (value){},
        ),
        Expanded(
          child: ColoursGridview(),
        ),
      ],
    );
  }
}