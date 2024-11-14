import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/header_item.dart';
import 'package:note_taking_app/entities/items/image_item.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/entities/items/text_item.dart';
import 'package:note_taking_app/widgets/item/canvasItem/show_canvas_dialog.dart';
import 'package:note_taking_app/widgets/item/imageItem/image_input/image_input.dart';
import 'package:note_taking_app/widgets/item/imageItem/image_input/show_image_dialog.dart';
import 'package:note_taking_app/widgets/note/screen/note_bottom_navigation_bar.dart';

import '../../../entities/note.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  final Function(Function()) homeState;

  const NoteScreen({super.key, required this.note, required this.homeState});

  @override
  State<StatefulWidget> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late Note note;
  late Function(Function()) homeState;
  late TextEditingController _titleController;


  @override
  void initState() {
    super.initState();
    note = widget.note;
    homeState = widget.homeState;
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
                  final file = File("${note.title.replaceAll(' ', '_')}.pdf");
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
          2: () =>
            ImageDialogShower().showImageDialog(context, setState, note),
          3: () =>
            CanvasDialogShower().showCanvasDialog(context, setState, note),
        }
      )
    );
  }

}

