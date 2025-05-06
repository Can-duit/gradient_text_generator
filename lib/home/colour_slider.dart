import 'package:flutter/material.dart';
import 'package:gradient_text_generator/databasing/provider.dart';
import 'package:gradient_text_generator/widgets.dart';
import 'package:provider/provider.dart';
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
    _loadBias();
    
    super.initState();
  }
  
  Future<void> _loadBias () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bias = prefs.getDouble('colour_bias') ?? 0.0;
    });
  }

   Future<void> _setBias (double input) async {
    setState(() {
      bias = input;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(mounted){
      await prefs.setDouble('colour_bias', input);
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