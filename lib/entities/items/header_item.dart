import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/text_item.dart';
import 'package:note_taking_app/widgets/item/header_item_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'dart:convert';

class HeaderItem extends TextItem {
  HeaderItem(super.text, super.noteId);

  HeaderItem.withId(int super.itemId, super.text, super.noteId)
      : super.withId();

  static HeaderItem fromJson(Map<String, dynamic> item) {
    var itemId = item["itemId"];
    var header = item["header"];
    var noteId = item["note"]["noteId"];
    return HeaderItem.withId(itemId, header, noteId);
  }

  @override
  Widget buildWidget(Function loadItems) =>
      HeaderItemWidget(item: this, loadItems: loadItems);

  @override
  pw.Page buildPdf() {
    return pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              text,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 16
              ),
            ),
          );
        }
    );
  }

  @override
  Map<String, dynamic> toJson() {
    var id = itemId != -1 ? '"itemId": $itemId,' : "";
    String item = '{$id"header": "$text","note": {"noteId": $noteId}}';
    return jsonDecode(item);
  }
}