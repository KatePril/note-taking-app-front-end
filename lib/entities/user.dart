import 'dart:convert';

class User {
  int? userId;
  String username;
  String password;

  User(this.userId, this.username, this.password);

  User.newUser(this.username, this.password);

  Map<String, dynamic> toJson() {
    var id = userId != null ? '"user_id": $userId,' : "";
    String user = '{$id"username": $username,"password": $password}';
    return jsonDecode(user);
  }

}