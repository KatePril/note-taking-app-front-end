import 'package:flutter/cupertino.dart';
import 'package:note_taking_app/entities/jsonable.dart';
import 'package:pdf/widgets.dart' as pw show Page;

abstract class Item implements Jsonable {
  Widget buildWidget(Function loadItems);
  pw.Page buildPdf();
}