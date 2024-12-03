import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/item_api.dart';
import 'package:note_taking_app/entities/items/image_item.dart';

class ImageItemWidget extends StatefulWidget {
  final ImageItem item;

  const ImageItemWidget({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends State<ImageItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme
          .of(context)
          .colorScheme
          .inversePrimary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.memory(widget.item.imageBytes, fit: BoxFit.fitWidth),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, // Makes the button fill the available width
              child: FilledButton(
                onPressed: () => ItemApi.deleteItemById(widget.item.itemId),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.error),
                ),
                child: const Icon(Icons.delete, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}