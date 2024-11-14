import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:note_taking_app/widgets/item/canvasItem/canvas/pencil.dart';

class NoteCanvas extends StatefulWidget {
  final Function(Future<Uint8List>) setImage;

  const NoteCanvas({super.key, required this.setImage});

  @override
  State<StatefulWidget> createState() => _NoteCanvasState();

}

class _NoteCanvasState extends State<NoteCanvas> {
  final List<Offset?> points = [];

  _NoteCanvasState();

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
        widget.setImage(_createImageBytes(context));
      },
      child: CustomPaint(
        painter: Pencil(points),
        size: Size.infinite,
      ),
    );
  }

  Future<Uint8List> _createImageBytes(BuildContext context) async {
    final screenSize = MediaQuery.of(context).size;
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(
      recorder,
      ui.Rect.fromPoints(
        const Offset(0, 0),
        Offset(screenSize.width, screenSize.height)
      )
    );

    Pencil(points).paint(canvas, Size(
      screenSize.width,
      screenSize.height
    ));

    final picture = recorder.endRecording();
    final img = await picture.toImage(
      screenSize.width.toInt(),
      screenSize.height.toInt()
    );
    final bytes = await img.toByteData(format: ui.ImageByteFormat.png);

    return bytes!.buffer.asUint8List();
  }

}