import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/item_api.dart';
import 'package:note_taking_app/entities/items/image_item.dart';
import 'package:note_taking_app/widgets/delete_button.dart';

class ImageItemWidget extends StatefulWidget {
  final ImageItem item;
  final Function loadItems;

  const ImageItemWidget({super.key, required this.item, required this.loadItems});

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
            DeleteButton(
              onPressed: () async {
                await ItemApi.deleteItemById(widget.item.itemId);
                widget.loadItems();
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}