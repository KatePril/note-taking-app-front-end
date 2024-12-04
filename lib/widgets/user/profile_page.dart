import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/user_api.dart';
import 'package:note_taking_app/entities/user.dart';
import 'package:note_taking_app/widgets/user/sign_in_log_in/user_input.dart';

class ProfilePage extends StatefulWidget {
  final int id;
  
  const ProfilePage(this.id, {super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
  
}

class _ProfilePageState extends State<ProfilePage> {
  User user = User.newUser("", "");
  String _oldPassword = "";
  String _message = "";
  late TextEditingController _usernameController;
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  
  @override
  void initState() {
    super.initState();
    _loadUser();
    _usernameController = TextEditingController(text: user.username);
    _oldPasswordController = TextEditingController(text: _oldPassword);
    _newPasswordController = TextEditingController(text: "");

  }

  void _loadUser() async {
    user = await UserApi.getUser(widget.id);
    _usernameController.text = user.username;
    setState(() {});
  }

  void _updateUsername() async {
    int id = await UserApi.changeUsername(user);
    if (id == -1) {
      setState(() => _message = "This username is already taken");
    } else {
      _loadUser();
      _message = "";
    }
  }

  void _updatePassword() async {
    int id = await UserApi.changePassword(user, _oldPassword);
    if (id == -1) {
      setState(() => _message = "Incorrect password");
    } else {
      _loadUser();
      _message = "";
    }
  }

  void _deleteUser() async {
    await UserApi.deleteUser(widget.id);
    while(Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(_message),
              const SizedBox(height: 8),
              UserInput(
                textController: _usernameController,
                onChanged: (value) {
                  setState(() => user.username = value);
                },
                labelText: null,
                hintText: user.username,
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _updateUsername,
                style: FilledButton.styleFrom(
                    backgroundColor: Theme
                        .of(context).colorScheme.primary
                ),
                child: const Text("Update username"),
              ),
              const SizedBox(height: 8),
              UserInput(
                textController: _oldPasswordController,
                onChanged: (value) {
                  setState(() => _oldPassword = value);
                },
                labelText: 'Old password',
                hintText: 'Enter old password',
              ),
              const SizedBox(height: 8),
              UserInput(
                textController: _newPasswordController,
                onChanged: (value) {
                  setState(() => user.password = value);
                },
                labelText: 'new password',
                hintText: 'Enter new password',
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _updatePassword,
                style: FilledButton.styleFrom(
                    backgroundColor: Theme
                        .of(context).colorScheme.primary
                ),
                child: const Text("Update password"),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _deleteUser,
                style: FilledButton.styleFrom(
                    backgroundColor: Theme
                        .of(context).colorScheme.error
                ),
                child: const Text("Delete account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}