import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/item_api.dart';
import 'package:note_taking_app/entities/items/canvas_item.dart';
import 'package:note_taking_app/widgets/item/canvasItem/show_canvas_dialog.dart';

class CanvasItemWidget extends StatefulWidget {
  final CanvasItem item;

  const CanvasItemWidget({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => _CanvasItemWidgetState();
}

class _CanvasItemWidgetState extends State<CanvasItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InkWell(
            onTap: () =>
              CanvasDialogShower()
                  .showCanvasDialog(context, () => setState(() {}), item: widget.item),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.memory(widget.item.imageBytes, fit: BoxFit.fitWidth,),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
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
    );
  }

}