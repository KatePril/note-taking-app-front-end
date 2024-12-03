import 'dart:convert';

import 'package:note_taking_app/entities/jsonable.dart';

class User implements Jsonable {
  int? userId;
  String username;
  String password;

  User(this.userId, this.username, this.password);

  User.newUser(this.username, this.password);

  @override
  Map<String, dynamic> toJson() {
    var id = userId != null ? '"user_id": $userId,' : "";
    String user = '{$id"username": "$username","password": "$password"}';
    return jsonDecode(user);
  }

}