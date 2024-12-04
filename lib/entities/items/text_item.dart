import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/widgets/item/text_item_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'dart:convert';

class TextItem implements Item {
  int? _itemId;
  String text;
  final int noteId;

  TextItem(this.text, this.noteId);

  TextItem.withId(this._itemId, this.text, this.noteId);

  int get itemId => _itemId ?? -1;

  static TextItem fromJson(Map<String, dynamic> item) {
    var itemId = item["itemId"];
    var text = item["text"];
    var noteId = item["note"]["noteId"];
    return TextItem.withId(itemId, text, noteId);
  }

  @override
  Widget buildWidget(Function loadItems) =>
      TextItemWidget(item: this, loadItems: loadItems);

  @override
  pw.Page buildPdf() {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text(
            text,
            style: const pw.TextStyle(
              fontSize: 14
            ),
          ),
        );
      }
    );
  }

  @override
  Map<String, dynamic> toJson() {
    var id = itemId != -1 ? '"itemId": $itemId,' : "";
    String item = '{$id"text": "$text","note": {"noteId": $noteId}}';
    return jsonDecode(item);
  }
}