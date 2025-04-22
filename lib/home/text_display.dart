import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_text_generator/widgets.dart';

class TextOutputWidget extends StatefulWidget {
  const TextOutputWidget({super.key});

  @override
  State<TextOutputWidget> createState() => _TextOutputWidgetState();
}

class _TextOutputWidgetState extends State<TextOutputWidget> {

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
    final ThemeData theme = Theme.of(context);

    return SizedBox.expand(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.colorScheme.tertiary,
          borderRadius: BorderRadius.circular(20)
          
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: StyledText(
                  'Generated Text:',
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
                  readOnly: true,
                  decoration: InputDecoration(
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