import 'package:note_taking_app/entities/items/item.dart';
import 'package:http/http.dart' as http;
import 'package:note_taking_app/entities/items/utils/item_factory.dart';
import 'dart:convert';

import 'constants.dart' as constants;

class ItemApi {
  ItemApi._internal();

  static final ItemApi _instance = ItemApi._internal();

  factory ItemApi() {
    return _instance;
  }

  static final _uri = "${constants.uri}items";

  static Future<String> createItem(Item item) async {
    http.Response response = await http.post(
      Uri.parse(_uri),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    return response.body;
  }

  static Future<String> updateItem(Item item) async {
    http.Response response = await http.put(
      Uri.parse(_uri),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    return response.body;
  }

  static Future<List<Item>> getItemsByNote(int id) async {
    http.Response response = await http.get(
      Uri.parse("$_uri/$id"),
    );
    List<Item> items = List.empty(growable: true);
    for (final item in jsonDecode(response.body)) {
      items.add(ItemFactory.createItem(item));
    }
    return items;
  }

  static Future<Item> getItemById(int id) async {
    http.Response response = await http.get(
      Uri.parse("$_uri/item/$id"),
    );
    return ItemFactory.createItem(
      jsonDecode(response.body),
    );
  }

  static Future<String> deleteItemById(int id) async {
    http.Response response = await http.delete(
      Uri.parse("$_uri/$id"),
    );
    return response.body;
  }
}