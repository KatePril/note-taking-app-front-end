import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/widgets/item/text_item_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TextItem extends Item {
  String _text;

  TextItem(this._text);

  String get text => _text;

  set text(String text) => _text = text;

  @override
  Widget buildWidget() => TextItemWidget(item: this);

  @override
  pw.Page buildPdf() {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text(
            _text,
            style: const pw.TextStyle(
              fontSize: 14
            ),
          ),
        );
      }
    );
  }
}