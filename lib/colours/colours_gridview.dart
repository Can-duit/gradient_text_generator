import 'package:flutter/material.dart';
import 'package:gradient_text_generator/databasing/database.dart';
import 'package:gradient_text_generator/databasing/provider.dart';
import 'package:gradient_text_generator/widgets.dart';
import 'package:provider/provider.dart';

class ColoursGridview extends StatefulWidget {
  const ColoursGridview({super.key});

  @override
  State<ColoursGridview> createState() => _ColoursGridviewState();
}

class _ColoursGridviewState extends State<ColoursGridview> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Consumer<ProviderService>(
          builder: (context, provider, child){
            return FutureBuilder(
              future: provider.getSearchedData(provider.search), 
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5), 
                    itemCount: provider.letterItem.length,
                    itemBuilder: (_, int index){
                      final LetterModel char = provider.letterItem[index];

                      return Card(
                        child: GridTile(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              StyledText(
                              "Character: ${char.letter}"
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StyledText("Colour:"),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      
                                      backgroundColor: WidgetStateProperty.all<Color>(Color.from(
                                        alpha: 1.0, red: char.r, green: char.g, blue: char.b)
                                      ),  
                                    ),
                                    onPressed: (){
                                      showDialog(
                                        context: context, 
                                        builder: (context){
                                          return LetterInputDialog(
                                            inputLetter: provider.letterItem[index].letter,
                                          );
                                        }
                                      );
                                    }, 
                                    child: StyledText('',)
                                  ),
                                ],
                              ),
                            ],
                          )
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }
            ); 
          }
        )
      ),
    );
  }
}