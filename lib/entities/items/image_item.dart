import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/widgets/item/image_item_widget.dart';

class ImageItem extends Item {
  final Uint8List image_bytes;

  ImageItem(this.image_bytes);

  @override
  Widget buildWidget() {
    return ImageItemWidget(item: this);
  }

}