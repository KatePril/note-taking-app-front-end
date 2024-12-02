import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/entities/items/utils/bytes_parser.dart';
import 'package:note_taking_app/entities/items/utils/offsets_parser.dart';
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


  CanvasItem.withId(this.itemId, this._imageBytes, this.points, this.noteId);

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
    var pointsParsed = OffsetsParser.parseOffsets(points);
    String item = '{$id"canvas": "${_imageBytes.toString()}", "offsets": "$pointsParsed", "note": {"noteId": $noteId}';
    return jsonDecode(item);
  }

  static CanvasItem fromJson(Map<String, dynamic> item) {
    var itemId = item["itemId"];
    var canvas = BytesParser.parseString(item["canvas"]);
    var points = OffsetsParser.parseString(item["offsets"]);
    var noteId = item["note"]["noteId"];
    return CanvasItem.withId(itemId, canvas, points, noteId);
  }

}