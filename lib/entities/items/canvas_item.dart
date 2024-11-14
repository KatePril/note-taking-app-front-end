import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/widgets/item/canvasItem/canvas_item_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CanvasItem extends Item {
  final Uint8List _imageBytes;

  CanvasItem(this._imageBytes);

  Uint8List get imageBytes => _imageBytes;

  @override
  Widget buildWidget() {
    return CanvasItemWidget(item: this);
  }

  @override
  pw.Page buildPdf() {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(
            pw.MemoryImage(_imageBytes)
          ),
        );
      }
    );
  }

}