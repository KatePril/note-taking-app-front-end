import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/item_api.dart';
import 'package:note_taking_app/db_connection/note_api.dart';
import 'package:note_taking_app/entities/items/header_item.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/entities/items/text_item.dart';
import 'package:note_taking_app/widgets/item/canvasItem/show_canvas_dialog.dart';
import 'package:note_taking_app/widgets/item/imageItem/image_input/show_image_dialog.dart';
import 'package:note_taking_app/widgets/note/screen/note_bottom_navigation_bar.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../entities/note.dart';

class NoteScreen extends StatefulWidget {
  final int id;
  final Function() homeState;

  const NoteScreen({super.key, required this.id, required this.homeState});

  @override
  State<StatefulWidget> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<Item> _items = List.empty(growable: true);
  Note _note = Note("", -1);
  late TextEditingController _titleController;


  @override
  void initState() {
    super.initState();
    _loadNote();
    _loadItems();
    _titleController = TextEditingController(text: _note.title);
  }

  Future<void> _loadNote() async {
    _note = await NoteApi.getNoteById(widget.id);
    setState(() {
      _titleController.text = _note.title;
    });
  }

  Future<void> _loadItems() async {
    _items = await ItemApi.getItemsByNote(widget.id);
    setState(() {});
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
                onChanged: (value) => _note.title = value,
              ),
            ),
            FilledButton(
              onPressed: () async {
                await NoteApi.updateNote(_note);
                for (final item in _items) {
                  await ItemApi.updateItem(item);
                }
                widget.homeState();
              },
              child: const Icon(Icons.save_as, size: 24),
            ),
            const SizedBox(width: 12),
            FilledButton(
                onPressed: () async {
                  final file = File("${_note.title.replaceAll(' ', '_')}.pdf");
                  pw.Document document = await _note.buildDocument();
                  await file.writeAsBytes(await document.save());
                },
                child: const Icon(Icons.save_alt, size: 24),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: _items.map((Item item) =>
                item.buildWidget(_loadItems)).toList(),
          ),
        ),
      bottomNavigationBar: NoteBottomNavigationBar(
        functions: {
          0: () async {
            await ItemApi.createItem(HeaderItem("", _note.noteId));
            _loadItems();
          },
          1: () async {
            ItemApi.createItem(TextItem("", _note.noteId));
            _loadItems();
          },
          2: () =>
            ImageDialogShower().showImageDialog(context, _loadItems, _note.noteId),
          3: () =>
            CanvasDialogShower().showCanvasDialog(context, _loadItems, noteId: _note.noteId),
        }
      )
    );
  }

}

