import 'package:flutter/material.dart';
import 'package:gradient_text_generator/widgets.dart';

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({super.key});

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  @override
  Widget build(BuildContext context) {

    return SizedBox.expand(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.purple[200],
          borderRadius: BorderRadius.circular(20)
          
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: StyledText(
                  'Input Text Here:',
                  styleColour: Colors.white,
                  bold: true,
                  fontSize: 35,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(

                  style: TextStyle(),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}