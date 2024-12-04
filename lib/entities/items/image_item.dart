import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/entities/items/utils/bytes_parser.dart';
import 'package:note_taking_app/widgets/item/imageItem/image_item_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'dart:convert';

class ImageItem implements Item {
  int? _itemId;
  final Uint8List _imageBytes;
  final int _noteId;

  ImageItem(this._imageBytes, this._noteId);

  ImageItem.withId(this._itemId, this._imageBytes, this._noteId);

  Uint8List get imageBytes => _imageBytes;

  int get itemId => _itemId ?? -1;

  static ImageItem fromJson(Map<String, dynamic> item) {
    var itemId = item["itemId"];
    var image = BytesParser.parseString(item["image"]);
    var noteId = item["note"]["noteId"];
    return ImageItem.withId(itemId, image, noteId);
  }

  @override
  Widget buildWidget(Function loadItems) =>
      ImageItemWidget(item: this, loadItems: loadItems);

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
    var id = _itemId != null ? '"itemId": $_itemId,' : "";
    String item = '{$id"image": "${_imageBytes.toString()}","note": {"noteId": $_noteId}}';
    return jsonDecode(item);
  }
}