import 'package:flutter/material.dart';
import 'package:gradient_text_generator/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


//TODO fix
class ColourSlider extends StatefulWidget {
  const ColourSlider({super.key});

  @override
  State<ColourSlider> createState() => _ColourSliderState();
}

class _ColourSliderState extends State<ColourSlider> {
  late double bias;

  @override
  void initState() {
    bias = 0.0;
    _loadBias;
    
    super.initState();
  }
  
  Future<void> _loadBias () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bias = prefs.getDouble('colour_bias') ?? 0.0;
    print('loaded bias to be $bias`');
  }

   Future<void> _setBias (double input) async {
    setState(() {
      bias = input;
      print('bias set to $bias`');
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(mounted){
      await prefs.setDouble('colour_bias', input);
      print('sent bias as $bias');
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        StyledText(
          'Colour Bias',
          bold: true,
          fontSize: 30.0,
          styleColour: theme.colorScheme.primary,
        ),
        Slider(
          value: bias, 
          onChanged: _setBias,
          label: 'bias: ${bias*100}%',
        ),
      ],
    );
  }
}