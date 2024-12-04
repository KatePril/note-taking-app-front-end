import 'dart:convert';

import 'package:note_taking_app/entities/jsonable.dart';

class User implements Jsonable {
  int? userId;
  String username;
  String password;

  User(this.userId, this.username, this.password);

  User.newUser(this.username, this.password);

  static User fromJson(Map<String, dynamic> user) {
    var userId = user["userId"];
    var username = user["username"];
    var password = user["password"];
    return User(userId, username, password);
  }

  @override
  Map<String, dynamic> toJson() {
    var id = userId != null ? '"userId": $userId,' : "";
    String user = '{$id"username": "$username","password": "$password"}';
    return jsonDecode(user);
  }

}