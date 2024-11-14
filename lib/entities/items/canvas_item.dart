import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/widgets/item/canvasItem/canvas/pencil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CanvasItem extends Item {
  final List<Offset?> _points = [];
  late Uint8List _image_bytes;

  List<Offset?> get points => _points;
  Uint8List get image_bytes => _image_bytes;

  @override
  Widget buildWidget() {
    // TODO: implement buildWidget
    throw UnimplementedError();
  }

  Future<void> prepareImageData() async =>
      _image_bytes = await _createImageBytes();

  @override
  pw.Page buildPdf() {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(
            pw.MemoryImage(_image_bytes)
          ),
        );
      }
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