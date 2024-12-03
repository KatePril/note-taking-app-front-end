  import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/item_api.dart';
import 'package:note_taking_app/entities/items/canvas_item.dart';
import 'package:note_taking_app/entities/note.dart';
import 'package:note_taking_app/widgets/item/canvasItem/canvas/canvas.dart';

class CanvasDialogShower {
  CanvasDialogShower._internal();

  static final CanvasDialogShower _instance = CanvasDialogShower._internal();

  factory CanvasDialogShower() => _instance;

  void showCanvasDialog(BuildContext context, Function() loadItems, {Note? note, CanvasItem? item}) {
    late Uint8List image;
    late List<Offset?> points;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.zero,
        child: SizedBox.expand(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('Draw your note'),
              actions: [
                FilledButton(
                  onPressed: () async {
                    Navigator.pop(context, 'Save');
                    if (note != null) {
                      await ItemApi.createItem(
                          CanvasItem(image, note.noteId)
                            ..points = points
                      );
                    }
                    if (item != null) {
                      item.imageBytes = image;
                      item.points = points;
                      ItemApi.updateItem(item);
                    }
                    loadItems();
                  },
                  child: const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            body: NoteCanvas(
              setImage: (Future<Uint8List> bytes, List<Offset?> offsets) async {
                image = await bytes;
                points = offsets;
              },
            )..points = item != null ? item.points : [],
          ),
        ),
      ),
    );
  }

}

