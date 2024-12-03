import 'package:note_taking_app/entities/items/canvas_item.dart';
import 'package:note_taking_app/entities/items/header_item.dart';
import 'package:note_taking_app/entities/items/image_item.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/entities/items/text_item.dart';

class ItemFactory {
  ItemFactory._internal();

  static final ItemFactory _instance = ItemFactory._internal();

  factory ItemFactory() {
    return _instance;
  }

  static Item createItem(Map<String, dynamic> item) {
    if (item["text"] != null) {
      return TextItem.fromJson(item);
    } else if (item["header"] != null) {
      return HeaderItem.fromJson(item);
    } else if (item["image"] != null) {
      return ImageItem.fromJson(item);
    } else if (item["canvas"] != null && item["offsets"] != null) {
      return CanvasItem.fromJson(item);
    } else {
      throw Exception("Unknown type of item");
    }
  }

}