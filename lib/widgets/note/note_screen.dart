import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/header_item.dart';
import 'package:note_taking_app/entities/items/image_item.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/entities/items/text_item.dart';
import 'package:note_taking_app/widgets/item/imageItem/image_input.dart';

import '../../entities/note.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  final Function(Function()) homeState;

  const NoteScreen({super.key, required this.note, required this.homeState});

  @override
  State<StatefulWidget> createState() => _NoteScreenState(note, homeState);
}

class _NoteScreenState extends State<NoteScreen> {
  final Note note;
  late TextEditingController _titleController;
  final Function(Function()) homeState;

  _NoteScreenState(this.note, this.homeState) {
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
                onChanged: (value) => homeState(() => note.title = value),
              ),
            ),
            FilledButton(
                onPressed: () {
                  // TODO
                },
                child: const Text("Save"),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: note.items.map((Item item) => item.buildWidget()).toList(),
          ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.h_mobiledata),
            label: 'Header',
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .onPrimaryContainer,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.text_fields),
            label: 'Text',
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .onPrimaryContainer,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.image),
            label: 'Image',
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .onPrimaryContainer,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.draw),
            label: 'Draw',
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .onPrimaryContainer,
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              setState(() {
                note.addItem(HeaderItem(""));
              });
              break;
            case 1:
              setState(() {
                note.addItem(TextItem(""));
              });
              break;
            case 2:
              late Uint8List image;
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Select images'),
                  content: MyImageInput(setImage: (Uint8List bytes) => image = bytes),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Save');
                        setState(() {
                          note.addItem(ImageItem(image));
                        });
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
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

