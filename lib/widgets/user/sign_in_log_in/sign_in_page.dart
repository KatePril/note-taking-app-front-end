import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/user_api.dart';
import 'package:note_taking_app/entities/user.dart';
import 'package:note_taking_app/widgets/home_page.dart';
import 'package:note_taking_app/widgets/user/sign_in_log_in/user_input.dart';

class SignInPage extends StatefulWidget {

  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignInPageState();

}

class _SignInPageState extends State<SignInPage> {
  User _user = User.newUser("", "");
  String _message = "";
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: _user.username);
    _passwordController = TextEditingController(text: _user.password);
  }

  void _clearState() {
    setState(() {
      _usernameController.text = "";
      _passwordController.text = "";
      _user = User.newUser("", "");
      _message = "";
    });
  }

  void _navigateToHome(int id) {
    _clearState();
    Navigator.push(
      context, MaterialPageRoute(
      builder: (context) => MyHomePage(
          title: 'Note Taker', id: id
        )
      )
    );
  }

  void _createNewUser() async {
    int id = await UserApi.createUser(_user);
    if (id == -1) {
      setState(() => _message = "Username already exists");
    } else {
      _navigateToHome(id);
    }
  }

  void _logIn() async {
    int id = await UserApi.getUserId(_user);
    if (id == -1) {
      setState(() => _message = "Incorrect username or password");
    } else {
      _navigateToHome(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
            child:Column(
            children: [
              Text(_message),
              const SizedBox(height: 16.0),
              UserInput(
                  textController: _usernameController,
                  onChanged: (value) {
                    setState(() => _user.username = value);
                  },
                  labelText: 'Username',
                  hintText: 'Enter your username',
              ),
              const SizedBox(height: 16.0),
              UserInput(
                  textController: _passwordController,
                  onChanged: (value) {
                    setState(() => _user.password = value);
                  },
                  labelText: 'Password',
                  hintText: 'Enter your password',
              ),
              const SizedBox(height: 16.0),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme
                      .of(context).colorScheme.primary
                ),
                onPressed: () => _logIn(),
                child: const Text("Log in"),
              ),
              const SizedBox(height: 16.0),
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Theme
                        .of(context).colorScheme.tertiary
                ),
                onPressed: () => _createNewUser(),
                child: const Text("Sign in"),
              ),
            ],
          ),
        ),
      )
    );
  }
}