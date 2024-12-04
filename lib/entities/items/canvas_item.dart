import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/entities/items/utils/bytes_parser.dart';
import 'package:note_taking_app/entities/items/utils/offsets_parser.dart';
import 'package:note_taking_app/widgets/item/canvasItem/canvas_item_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'dart:convert';

class CanvasItem implements Item {
  int? _itemId;
  Uint8List imageBytes;
  List<Offset?> points = [];
  final int _noteId;

  CanvasItem(this.imageBytes, this._noteId);

  int get itemId => _itemId ?? -1;

  CanvasItem.withId(this._itemId, this.imageBytes, this.points, this._noteId);

  static CanvasItem fromJson(Map<String, dynamic> item) {
    var itemId = item["itemId"];
    var canvas = BytesParser.parseString(item["canvas"]);
    var points = OffsetsParser.parseString(item["offsets"]);
    var noteId = item["note"]["noteId"];
    return CanvasItem.withId(itemId, canvas, points, noteId);
  }

  @override
  Widget buildWidget(Function loadItems) =>
      CanvasItemWidget(item: this, loadItems: loadItems);

  @override
  pw.Page buildPdf() {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(
            pw.MemoryImage(imageBytes)
          ),
        );
      }
    );
  }

  @override
  Map<String, dynamic> toJson() {
    var id = _itemId != null ? '"itemId": $_itemId,' : "";
    var pointsParsed = OffsetsParser.parseOffsets(points);
    String item = '{$id"canvas": "${imageBytes.toString()}", "offsets": "$pointsParsed", "note": {"noteId": $_noteId}}';
    return jsonDecode(item);
  }

}