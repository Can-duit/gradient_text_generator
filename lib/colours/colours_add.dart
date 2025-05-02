import 'package:flutter/material.dart';
import 'package:gradient_text_generator/databasing/provider.dart';
import 'package:gradient_text_generator/widgets.dart';
import 'package:provider/provider.dart';

class AddColoursWidget extends StatefulWidget {

  const AddColoursWidget({super.key});

  @override
  State<AddColoursWidget> createState() => _AddColoursWidgetState();
}

class _AddColoursWidgetState extends State<AddColoursWidget> {
  late TextEditingController _controller;
  String search = '';

  @override
  void initState() {
    _controller = TextEditingController();
    _searchData(false);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _searchData (bool notify){
    Provider.of<ProviderService>(context, listen: false).setSearch(search, notify);
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
                    return LetterInputDialog();
                  }
                  );
              },
              icon: Icon(
                Icons.add_circle,
                color: theme.colorScheme.secondary,
                size: 35,
              ),
            ),
            Expanded(child: VerticalDivider()),
            SizedBox(
              width: 50,
              child: TextField(
                onChanged: (value){
                  setState(() {
                    if(value != ' '&& value != '\n' && value != '\t'){
                      search = value;
                    }
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
                _searchData(true);
              },
              icon: Icon(
                Icons.search,
                color: theme.colorScheme.secondary,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}