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

  static final _uri = "${constants.uri}users";

  static Future<int> createUser(User user) async {
    final c1 = Crypt.sha256(user.password, rounds: 10000);
    user.password = c1.toString();

    http.Response response = await http.post(
      Uri.parse(_uri),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    return int.parse(response.body);
  }

  static Future<int> getUserId(User user) async {
    http.Response response = await http.get(
      Uri.parse("$_uri/${user.username}"),
    );
    if (response.body.isNotEmpty) {
      var userJson = jsonDecode(response.body);
      var password = userJson["password"];
      final h = Crypt(password);
      return h.match(user.password) ? userJson["userId"] : -1;
    }
    return -1;
  }

  static Future<User> getUser(int id) async {
    http.Response response = await http.get(
      Uri.parse("$_uri/user/$id"),
    );
    return User.fromJson(jsonDecode(response.body));
  }

  static Future<int> changeUsername(User user) async {
    http.Response response = await http.put(
      Uri.parse("$_uri/username"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    return int.parse(response.body);
  }

  static Future<int> changePassword(User user, String oldPassword) async {
    http.Response password = await http.get(
      Uri.parse("$_uri/password/${user.userId}"),
    );

    if (password.body.isNotEmpty) {
      final h = Crypt(password.body);
      if (h.match(oldPassword)) {
        final c1 = Crypt.sha256(user.password, rounds: 10000);
        user.password = c1.toString();

        http.Response response = await http.put(
          Uri.parse("$_uri/password"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(user.toJson()),
        );

        return int.parse(response.body);
      }
    }

    return -1;
  }
  
  static Future<String> deleteUser(int id) async {
    http.Response response = await http.delete(
      Uri.parse("$_uri/$id"),
    );
    return response.body;
  }

}