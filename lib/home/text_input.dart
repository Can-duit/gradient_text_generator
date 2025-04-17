import 'package:flutter/material.dart';
import 'package:gradient_text_generator/widgets.dart';

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({super.key});

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {

  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (String text){
                    // TODO add in a submit function
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Type Here',
                    border: InputBorder.none,
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}