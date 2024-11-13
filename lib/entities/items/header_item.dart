import 'package:flutter/src/widgets/framework.dart';
import 'package:note_taking_app/entities/items/text_item.dart';
import 'package:note_taking_app/widgets/item/header_item_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HeaderItem extends TextItem {
  HeaderItem(super._text);

  @override
  Widget buildWidget() => HeaderItemWidget(item: this);

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
}