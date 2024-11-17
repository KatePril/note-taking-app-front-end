  import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/canvas_item.dart';
import 'package:note_taking_app/entities/note.dart';
import 'package:note_taking_app/widgets/item/canvasItem/canvas/canvas.dart';

class CanvasDialogShower {
  CanvasDialogShower._internal();

  static final CanvasDialogShower _instance = CanvasDialogShower._internal();

  factory CanvasDialogShower() => _instance;

  void showCanvasDialog(BuildContext context, Function(Function()) setState, {Note? note, CanvasItem? item}) {
    late Uint8List image;
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
                  onPressed: () {
                    Navigator.pop(context, 'Save');
                    setState(() {
                      note?.addItem(CanvasItem(image));
                      item?.imageBytes = image;
                    });
                  },
                  child: const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            body: NoteCanvas(
              setImage: (Future<Uint8List> bytes) async => image = await bytes
            ),
          ),
        ),
      ),
    );
  }

}

