import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/canvas_item.dart';
import 'package:note_taking_app/entities/items/header_item.dart';
import 'package:note_taking_app/entities/items/image_item.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/entities/items/text_item.dart';
import 'package:note_taking_app/widgets/item/canvasItem/canvas/canvas.dart';
import 'package:note_taking_app/widgets/item/imageItem/image_input.dart';
import 'package:note_taking_app/widgets/note/screen/note_bottom_navigation_bar.dart';

import '../../../entities/note.dart';

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
                onPressed: () async {
                  final file = File("${note.title}.pdf");
                  await file.writeAsBytes(await note.buildDocument().save());
                },
                child: const Text("Export"),
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
      bottomNavigationBar: NoteBottomNavigationBar(
        functions: {
          0: () => setState(() {
            note.addItem(HeaderItem(""));
          }),
          1: () => setState(() {
            note.addItem(TextItem(""));
          }),
          2: () {
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
          },
          3: () {
            late Uint8List image;
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => Dialog(
                insetPadding: EdgeInsets.zero, // Removes padding around the dialog
                child: SizedBox.expand( // Makes the dialog take up the full screen
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                      title: const Text('Draw your note'),
                      actions: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context, 'Save');
                            setState(() {
                              note.addItem(CanvasItem(image));
                            });
                          },
                          child: const Text('Save', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    body: NoteCanvas(setImage: (Future<Uint8List> bytes) async => image = await bytes),
                  ),
                ),
              ),
            );
          }
        }
      )
    );
  }

}

