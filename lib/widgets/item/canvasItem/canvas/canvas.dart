import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:note_taking_app/widgets/item/canvasItem/canvas/pencil.dart';

class NoteCanvas extends StatefulWidget {
  final Function(Future<Uint8List>) setImage;

  const NoteCanvas({super.key, required this.setImage});

  @override
  State<StatefulWidget> createState() => _NoteCanvasState(setImage);

}

class _NoteCanvasState extends State<NoteCanvas> {
  final List<Offset?> points = [];
  final Function(Future<Uint8List>) setImage;

  _NoteCanvasState(this.setImage);

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
        setImage(_createImageBytes());
      },
      child: CustomPaint(
        painter: Pencil(points),
        size: Size.infinite,
      ),
    );
  }

  Future<Uint8List> _createImageBytes() async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(
        recorder,
        ui.Rect.fromPoints(
            const Offset(0, 0),
            const Offset(500, 500)
        )
    );

    Pencil(points).paint(canvas, const Size(500, 500));

    final picture = recorder.endRecording();
    final img = await picture.toImage(500, 500);
    final bytes = await img.toByteData(format: ui.ImageByteFormat.png);

    return bytes!.buffer.asUint8List();
  }

}