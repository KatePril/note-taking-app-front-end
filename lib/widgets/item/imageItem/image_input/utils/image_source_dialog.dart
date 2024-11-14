import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';

class ImageSourceProvider {
  ImageSourceProvider._internal();

  static final ImageSourceProvider _instance = ImageSourceProvider._internal();

  factory ImageSourceProvider() {
    return _instance;
  }

  Future<ImageSource> Function(BuildContext) get getImageSource => (BuildContext context) {
    return showDialog<ImageSource>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              child: const Text("Camera"),
              onPressed: () {
                Navigator.of(context).pop(ImageSource.camera);
              },
            ),
            SimpleDialogOption(
              child: const Text("Gallery"),
              onPressed: () {
                Navigator.of(context).pop(ImageSource.gallery);
              }
            ),
          ],
        );
      },
    ).then((value) {
      return value ?? ImageSource.gallery;
    });
  };

}