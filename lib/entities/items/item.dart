import 'package:flutter/cupertino.dart';
import 'package:pdf/widgets.dart' as pw show Page;

abstract class Item {
  Widget buildWidget();
  pw.Page buildPdf();
  Map<String, dynamic> toJson();
}