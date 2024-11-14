import 'package:flutter/material.dart';
import 'package:note_taking_app/widgets/item/canvasItem/canvas/pencil.dart';

class NoteCanvas extends StatefulWidget {

  const NoteCanvas({super.key});

  @override
  State<StatefulWidget> createState() => _NoteCanvasState();

}

class _NoteCanvasState extends State<NoteCanvas> {
  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          points.add(details.localPosition);
        });
      },
      onPanEnd: (details) {
        points.add(null);
      },
      child: CustomPaint(
        painter: Pencil(points),
        size: Size.infinite,
      ),
    );
  }


}