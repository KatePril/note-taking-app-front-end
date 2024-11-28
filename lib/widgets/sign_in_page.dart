import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/user_api.dart';
import 'package:note_taking_app/entities/user.dart';
import 'package:note_taking_app/widgets/home_page.dart';

class SignInPage extends StatefulWidget {
  User user = User.newUser("", "");
  String message = "";

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

  void navigateToHome(int id) {
    Navigator.push(
        context, MaterialPageRoute(
        builder: (context) => MyHomePage(
            title: 'Note Taker',
            id: id
        )
    )
    );
  }

  void createNewUser() async {
    int id = await UserApi.createUser(widget.user);
    if (id == -1) {
      setState(() {
        widget.message = "Username already exists";
      });
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
              TextField(
                controller: _usernameController,
                onChanged: (value) {
                  setState(() {
                    widget.user.username = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(color: Theme
                      .of(context).colorScheme.onTertiary),
                  labelStyle: TextStyle(color: Theme
                      .of(context).colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme
                        .of(context).colorScheme.primary, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme
                        .of(context).colorScheme.onTertiary, width: 1.0),
                  ),
                  filled: true, // Adds a background color
                  fillColor: Theme
                      .of(context).colorScheme.inversePrimary, // Background color
                  prefixIcon: const Icon(Icons.person), // Icon inside the TextField
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                onChanged: (value) {
                  setState(() {
                    widget.user.password = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Theme
                      .of(context).colorScheme.onTertiary),
                  labelStyle: TextStyle(color: Theme
                      .of(context).colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme
                        .of(context).colorScheme.primary, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme
                        .of(context).colorScheme.onTertiary, width: 1.0),
                  ),
                  filled: true, // Adds a background color
                  fillColor: Theme
                      .of(context).colorScheme.inversePrimary, // Background color
                  prefixIcon: const Icon(Icons.password), // Icon inside the TextField
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme
                      .of(context).colorScheme.primary
                ),
                onPressed: () {
                  navigateToHome(0);
                },
                child: const Text("Log in"),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Theme
                        .of(context).colorScheme.tertiary
                ),
                onPressed: () {
                  createNewUser();
                },
                child: const Text("Sign in"),
              ),
            ],
          ),
        ),
      )
    );
  }

}