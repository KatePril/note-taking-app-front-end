import 'package:note_taking_app/entities/items/item.dart';

class Note {
  String _title;
  final List<Item> _items = List.empty(growable: true);

  Note(this._title);

  String get title => _title;

  List<Item> get items => _items;

  set title(String title) => _title = title;

  void addItem(Item item) => _items.add(item);

}