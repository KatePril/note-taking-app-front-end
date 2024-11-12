import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/widgets/item/text_item_widget.dart';

class TextItem extends Item {
  String _text;

  TextItem(this._text);

  String get text => _text;

  set text(String text) => _text = text;

  @override
  Widget buildWidget() => TextItemWidget(item: this);
}