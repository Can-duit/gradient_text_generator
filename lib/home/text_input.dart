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
    String inputText = '';
    final ThemeData theme = Theme.of(context);

    return SizedBox.expand(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
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
                  styleColour: theme.colorScheme.secondary,
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
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  maxLines: 5,
                  controller: _controller,
                  onChanged: (String text){
                    setState(() {
                      inputText = text;
                    });
                  },
                  style: TextStyle(
                    fontFamily: 'AnonymousPro',
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.check_circle),
                      iconSize: 40,
                      onPressed: (){
                        
                        // TODO submit to the database
                      },
                    ),
                    suffixIconColor: theme.primaryColor,
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