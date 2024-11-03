import 'package:flutter/material.dart';
import '../../entities/note.dart';

class NoteScreen extends StatefulWidget {
  final Note note;

  const NoteScreen({super.key, required this.note});

  @override
  State<StatefulWidget> createState() => _NoteScreenState(note);
}

class _NoteScreenState extends State<NoteScreen> {
  final Note note;

  _NoteScreenState(this.note);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(note.title),
    );
  }

}

