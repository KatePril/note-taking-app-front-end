import 'package:note_taking_app/entities/items/item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart' as constants;

class ItemApi {
  ItemApi._internal();

  static final ItemApi _instance = ItemApi._internal();

  factory ItemApi() {
    return _instance;
  }

  static final _uri = "${constants.uri}items";

  static void createItem(Item item) async {
    await http.post(
      Uri.parse(_uri),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
  }

  static void updateItem(Item item) async {
    
  }
}