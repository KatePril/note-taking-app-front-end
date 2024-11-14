import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  String title;

  NoteWidget(this.title, {super.key});

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
            title,
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