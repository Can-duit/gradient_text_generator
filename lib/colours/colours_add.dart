import 'package:flutter/material.dart';
import 'package:gradient_text_generator/databasing/provider.dart';
import 'package:gradient_text_generator/widgets.dart';
import 'package:provider/provider.dart';

// This is the Add Character and Search Character menubar widget, found at the top of the colours tab
class AddColoursWidget extends StatefulWidget {

  const AddColoursWidget({super.key});

  @override
  State<AddColoursWidget> createState() => _AddColoursWidgetState();
}
class _AddColoursWidgetState extends State<AddColoursWidget> {
  
  // Variables for searching for characters
  late TextEditingController _controller;
  String search = '';

  // Runs upon initialization. Creates the controller and searches the database for all characters and colours.
  @override
  void initState() {
    _controller = TextEditingController();
    _searchData(false);
    super.initState();
  }

  // Runs when widget is no longer being displayed. Gets rid of the controller to avoid errors.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Searches for data with an inputted search, and will notify gridview to update when searched and notify is true
  void _searchData (bool notify){
    Provider.of<ProviderService>(context, listen: false).setSearch(search, notify);
  }

  // Creating the widget tree
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context); // Getting theme data
    
    // Sized box and container create the 
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
            StyledText(
              'Search Character',
              styleColour: theme.colorScheme.secondary,
              bold: true,
              fontSize: 25,
            ),
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