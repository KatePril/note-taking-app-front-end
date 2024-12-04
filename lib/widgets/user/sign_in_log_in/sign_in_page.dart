import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/user_api.dart';
import 'package:note_taking_app/entities/user.dart';
import 'package:note_taking_app/widgets/home_page.dart';
import 'package:note_taking_app/widgets/user/sign_in_log_in/sign_in_input.dart';

class SignInPage extends StatefulWidget {
  User user = User.newUser("", "");
  String message = "";

  SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignInPageState();

}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _passwordController = TextEditingController(text: widget.user.password);
  }

  void clearState() {
    setState(() {
      _usernameController.text = "";
      _passwordController.text = "";
      widget.user = User.newUser("", "");
      widget.message = "";
    });
  }

  void navigateToHome(int id) {
    clearState();
    Navigator.push(
      context, MaterialPageRoute(
      builder: (context) => MyHomePage(
          title: 'Note Taker', id: id
        )
      )
    );
  }

  void createNewUser() async {
    int id = await UserApi.createUser(widget.user);
    if (id == -1) {
      setState(() => widget.message = "Username already exists");
    } else {
      navigateToHome(id);
    }
  }

  void logIn() async {
    int id = await UserApi.getUserId(widget.user);
    if (id == -1) {
      setState(() => widget.message = "Incorrect username or password");
    } else {
      navigateToHome(id);
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
              Text(widget.message),
              const SizedBox(height: 16.0),
              SignInInput(
                  textController: _usernameController,
                  onChanged: (value) {
                    setState(() => widget.user.username = value);
                  },
                  labelText: 'Username',
                  hintText: 'Enter your username',
              ),
              const SizedBox(height: 16.0),
              SignInInput(
                  textController: _passwordController,
                  onChanged: (value) {
                    setState(() => widget.user.password = value);
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
                onPressed: () => logIn(),
                child: const Text("Log in"),
              ),
              const SizedBox(height: 16.0),
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Theme
                        .of(context).colorScheme.tertiary
                ),
                onPressed: () => createNewUser(),
                child: const Text("Sign in"),
              ),
            ],
          ),
        ),
      )
    );
  }

}