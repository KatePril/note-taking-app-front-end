import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/widgets/item/imageItem/image_item_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ImageItem extends Item {
  final Uint8List image_bytes;

  ImageItem(this.image_bytes);

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
          child:  pw.Image(pw.MemoryImage(image_bytes)),
        );
      }
    );
  }

}