import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  String title;

  Note(this.title, {super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: SizedBox(
        height: 50,
        child: Center(child: Text(
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