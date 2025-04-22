import 'package:flutter/material.dart';
import 'package:gradient_text_generator/widgets.dart';

class AddColoursWidget extends StatefulWidget {
  const AddColoursWidget({super.key});

  @override
  State<AddColoursWidget> createState() => _AddColoursWidgetState();
}

class _AddColoursWidgetState extends State<AddColoursWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    
    return SizedBox.expand(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(20)
          
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledText(
              'Add Characters',
              styleColour: theme.colorScheme.secondary,
              bold: true,
              fontSize: 35,  
            ),
            IconButton(
              onPressed: (){

                // TODO add character with pop-up
              }, 
              icon: Icon(
                Icons.add_circle,
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