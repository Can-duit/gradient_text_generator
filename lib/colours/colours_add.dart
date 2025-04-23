import 'package:flutter/material.dart';
import 'package:gradient_text_generator/widgets.dart';

class AddColoursWidget extends StatefulWidget {
  final Function(String) searchFunction;

  const AddColoursWidget({
    required this.searchFunction,
    super.key
    });

  @override
  State<AddColoursWidget> createState() => _AddColoursWidgetState();
}

class _AddColoursWidgetState extends State<AddColoursWidget> {
  late TextEditingController _controller;
  String search = '';

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
    ThemeData theme = Theme.of(context);
    
    return SizedBox(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(20)
          
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledText(
              'Add Character',
              styleColour: theme.colorScheme.secondary,
              bold: true,
              fontSize: 25,  
            ),
            IconButton(
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: (BuildContext context){
                    return Placeholder();
                  }
                  );
                // TODO add character with pop-up
              }, 
              icon: Icon(
                Icons.add_circle,
                color: theme.colorScheme.secondary,
                size: 35,
              ),
            ),
            /*Expanded(child: VerticalDivider()),
            SizedBox(
              width: 50,
              child: TextField(
                onChanged: (value){
                  setState(() {
                    search = value;
                  });
                  _controller.selection = TextSelection(
                    baseOffset: 0, 
                    extentOffset: _controller.value.text.length
                  );
                },
                maxLength: 1,
                cursorColor: theme.colorScheme.secondary,
                textAlign: TextAlign.end,
                controller: _controller,
                
                
                style: TextStyle(
                  fontFamily: 'AnonymousPro',
                  fontSize: 20,
                  color: theme.colorScheme.secondary
                ),
                
                
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.secondary)
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.secondary)
                  ),
                  counterText: ''
                ),
              ),
            ),
            IconButton(
              onPressed: (){
                widget.searchFunction(search);
              }, 
              icon: Icon(
                Icons.search,
                color: theme.colorScheme.secondary,
                size: 35,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}