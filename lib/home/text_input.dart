import 'package:flutter/material.dart';
import 'package:gradient_text_generator/databasing/provider.dart';
import 'package:gradient_text_generator/widgets.dart';
import 'package:provider/provider.dart';

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({super.key});

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {

  late TextEditingController _controller;
  late String inputText;

  @override
  void initState() {
    inputText = '';
    _controller = TextEditingController();
    _loadPrevText();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadPrevText() {
    inputText = Provider.of<ProviderService>(context, listen: false).inputText;
    _controller = TextEditingController(text: inputText);
  }

  void _onTextChanged (String value){
    String text = value;
    if(value.endsWith('\n')){
      text = value.trim();
      _controller.text = text.trim();
    }

    setState(() {
      inputText = value;
      if(value.endsWith('\n')){
        _onButtonPressed();
      }
    });
  }

  void _onButtonPressed (){
    Provider.of<ProviderService>(context, listen: false).sendInputText(inputText);

  }

  @override
  Widget build(BuildContext context) {
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
                  
                  onChanged: _onTextChanged,

                  style: TextStyle(
                    fontFamily: 'AnonymousPro',
                    fontSize: 20
                  ),

                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.check_circle),
                      iconSize: 40,
                      onPressed: _onButtonPressed,
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