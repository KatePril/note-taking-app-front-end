import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/canvas_item.dart';

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
      child: InkWell(
        onTap: () {
          //TODO
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.memory(widget.item.imageBytes, fit: BoxFit.fitWidth,),
        ),
      ),
    );
  }

}