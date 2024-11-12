import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/image_item.dart';

class ImageItemWidget extends StatefulWidget {
  final ImageItem item;

  const ImageItemWidget({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => _ImageItemWidgetState(item);
}

class _ImageItemWidgetState extends State<ImageItemWidget> {
  final ImageItem item;

  _ImageItemWidgetState(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme
          .of(context)
          .colorScheme
          .inversePrimary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.memory(item.image_bytes, fit: BoxFit.fitWidth,),
      ),
    );
  }

}