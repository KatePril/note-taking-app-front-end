import 'package:crypt/crypt.dart';
import 'package:note_taking_app/entities/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart' as constants;

class UserApi {
  UserApi._internal();

  static final UserApi _instance = UserApi._internal();

  factory UserApi() {
    return _instance;
  }

  static final _uri = Uri.parse("${constants.uri}users");

  static Future<int> createUser(User user) async {
    final c1 = Crypt.sha256(user.password, rounds: 10000);
    user.password = c1.toString();

    http.Response response = await http.post(
      _uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    return int.parse(response.body);
  }

}