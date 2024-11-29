import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/widgets/item/canvasItem/canvas_item_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'dart:convert';

class CanvasItem extends Item {
  int? itemId;
  Uint8List _imageBytes;
  List<Offset?> points = [];
  final int noteId;

  CanvasItem(this._imageBytes, this.noteId);

  Uint8List get imageBytes => _imageBytes;

  set imageBytes(Uint8List value) {
    _imageBytes = value;
  }

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

  @override
  Map<String, dynamic> toJson() {
    var id = itemId != null ? '"itemId": $itemId,' : "";
    var pointsParsed = '[${points.map((offset) {
      if (offset != null) {
        return '(${offset.dx}, ${offset.dy})';
      } else {
        return '(null, null)';
      }
    }).join(', ')}]';
    String item = '{$id"canvas": ${_imageBytes.toString()}, "offsets": $pointsParsed, "note": {"noteId": $noteId}';
    return jsonDecode(item);
  }

}