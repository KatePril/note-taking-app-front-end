import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/entities/items/text_item.dart';
import '../../entities/note.dart';

class NoteScreen extends StatefulWidget {
  final Note note;

  const NoteScreen({super.key, required this.note});

  @override
  State<StatefulWidget> createState() => _NoteScreenState(note);
}

class _NoteScreenState extends State<NoteScreen> {
  final Note note;
  late TextEditingController _titleController;
  late Function(Function()) homeState;

  _NoteScreenState(this.note) {
    _titleController = TextEditingController(text: note.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _titleController,
                onChanged: (value) => note.title = _titleController.text,
              ),
            ),
            FilledButton(
                onPressed: () {
                },
                child: Text("Save"),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: note.items.map((Item item) => item.buildWidget()).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.h_mobiledata),
            label: 'Header',
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .onPrimaryContainer,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: 'Text',
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .onPrimaryContainer,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Image',
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .onPrimaryContainer,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.draw),
            label: 'Draw',
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .onPrimaryContainer,
          ),
        ],
        onTap: (index) {
          // Handle navigation or functionality for each button here
          switch (index) {
            case 0:
              setState(() {
                note.addItem(TextItem(""));
              });
              break;
            case 1:
              note.addItem(TextItem(""));
              break;
            case 2:
              note.addItem(TextItem(""));
              break;
            case 3:
              note.addItem(TextItem(""));
              break;
          }
        },
      ),
    );
  }

}

