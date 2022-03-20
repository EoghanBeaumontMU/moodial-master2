import 'package:Moodial/models/user.dart';
import 'package:flutter/material.dart';
import 'package:Moodial/services/api.dart';

class SignUpForm extends StatefulWidget {
  final Function callback;
  final bool isLoggedIn;
  final User user;

  SignUpForm({
    this.callback,
    this.isLoggedIn,
    this.user,
  });

  @override
  _SignUpFormState createState() => _SignUpFormState(
        callback: this.callback,
        isLoggedIn: this.isLoggedIn,
        user: this.user,
      );
}

class _SignUpFormState extends State<SignUpForm> {
  Function callback;
  bool isLoggedIn;
  User user;

  _SignUpFormState({this.callback, this.isLoggedIn, this.user});
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    emailController.dispose();
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
              controller: emailController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Email',
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
                child: Text('Sign Up'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing data')));
                    ApiService.register(
                      usernameController.text,
                      emailController.text,
                      passwordController.text,
                    ).then((statusCode) {
                      if (statusCode == 200 || statusCode == 201) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Successful sign up. Logging you in...')),
                        );
                        // After successful sign up, log the user in
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
                      } else if (statusCode == 400) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('User already exists. Try new data...')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Error signing up. Please try again...')));
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
