import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/canvas_item.dart';
import 'package:note_taking_app/widgets/item/canvasItem/show_canvas_dialog.dart';
import 'package:note_taking_app/widgets/item/delete_item_button.dart';

class CanvasItemWidget extends StatefulWidget {
  final CanvasItem item;
  final Function loadItems;

  const CanvasItemWidget({super.key, required this.item, required this.loadItems});

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
          DeleteItemButton(itemId: widget.item.itemId, loadItems: widget.loadItems),
        ],
      ),
    );
  }

}