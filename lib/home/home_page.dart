import 'package:flutter/material.dart';
import 'package:gradient_text_generator/home/text_display.dart';
import 'package:gradient_text_generator/home/text_input.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextInputWidget()
        ),
        Expanded(
          child: TextOutputWidget()
        ),
      ],
    );
  }
}