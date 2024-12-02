import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/item_api.dart';
import 'package:note_taking_app/entities/items/image_item.dart';
import 'package:note_taking_app/entities/note.dart';
import 'package:note_taking_app/widgets/item/imageItem/image_input/image_input.dart';

class ImageDialogShower {
  ImageDialogShower._internal();

  static final ImageDialogShower _instance = ImageDialogShower._internal();

  factory ImageDialogShower() => _instance;

  void showImageDialog(BuildContext context, Function(Function()) setState, Note note) {
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
                ItemApi.createItem(ImageItem(image, note.noteId));
                // note.addItem(ImageItem(image, note.noteId));
              });
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
