
import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/canvas_item.dart';

class CanvasItemWidget extends StatefulWidget {
  final CanvasItem item;

  const CanvasItemWidget({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => _CanvasItemWidgetState();
}

class _CanvasItemWidgetState extends State<CanvasItemWidget> {
  late CanvasItem item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          //TODO
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.memory(item.image_bytes, fit: BoxFit.fitWidth,),
        ),
      ),
    );
  }

}