import 'package:flutter/material.dart';

class NoteWidget extends StatefulWidget {
  String title;

  NoteWidget(this.title, {super.key});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme
          .of(context)
          .colorScheme
          .primary,
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18, // Change the font size here
              fontWeight: FontWeight.bold, // Make the text bold
              color: Colors.white, // Change text color if needed
            ),
          )
        ),
      ),
    );
  }
}