import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/widgets/item/imageItem/image_item_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'dart:convert';

class ImageItem extends Item {
  int? itemId;
  final Uint8List _imageBytes;
  final int noteId;

  ImageItem(this._imageBytes, this.noteId);

  ImageItem.withId(this.itemId, this._imageBytes, this.noteId);

  Uint8List get imageBytes => _imageBytes;

  @override
  Widget buildWidget() {
    return ImageItemWidget(item: this);
  }

  @override
  pw.Page buildPdf() {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child:  pw.Image(pw.MemoryImage(_imageBytes)),
        );
      }
    );
  }

  @override
  Map<String, dynamic> toJson() {
    var id = itemId != null ? '"itemId": $itemId,' : "";
    String item = '{$id"image": ${_imageBytes.toString()},"note": {"noteId": $noteId}';
    return jsonDecode(item);
  }

}