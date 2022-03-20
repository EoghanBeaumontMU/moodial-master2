import 'package:Moodial/models/user.dart';
import 'package:flutter/material.dart';
import 'package:Moodial/services/api.dart';

class LoginForm extends StatefulWidget {
  final Function callback;
  final bool isLoggedIn;
  final User user;

  LoginForm({this.callback, this.isLoggedIn, this.user});

  @override
  _LoginFormState createState() => _LoginFormState(
        callback: this.callback,
        isLoggedIn: this.isLoggedIn,
        user: this.user,
      );
}

class _LoginFormState extends State<LoginForm> {
  Function callback;
  bool isLoggedIn;
  User user;

  _LoginFormState({
    this.callback,
    this.isLoggedIn,
    this.user,
  });
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Username',
              ),
              enableSuggestions: false,
              autocorrect: false,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 10.0,
              ),
              child: ElevatedButton(
                child: Text('Log In'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing data')));
                    ApiService.login(
                      usernameController.text,
                      passwordController.text,
                    ).then((user) {
                      if (user.loginStatus == 'User logged in') {
                        user.username = usernameController.text;
                        this.callback(true, user);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(user.loginStatus)));
                      }
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Something {
  static int counter;
}