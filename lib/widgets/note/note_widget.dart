import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/note.dart';

class NoteWidget extends StatefulWidget {
  String title;

  NoteWidget(this.title, {super.key});

  @override
  State<NoteWidget> createState() => _NoteState();
}

class _NoteState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
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