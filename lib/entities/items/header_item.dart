import 'package:flutter/src/widgets/framework.dart';
import 'package:note_taking_app/entities/items/text_item.dart';
import 'package:note_taking_app/widgets/item/header_item_widget.dart';

class HeaderItem extends TextItem {
  HeaderItem(super.text);

  @override
  Widget buildWidget() => HeaderItemWidget(item: this);
}