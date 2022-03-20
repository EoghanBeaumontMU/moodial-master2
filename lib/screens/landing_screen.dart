import 'package:Moodial/models/user.dart';
import 'package:Moodial/widgets/landing_screen/login_form.dart';
import 'package:Moodial/widgets/landing_screen/signup_form.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  final Function callback;
  final bool isLoggedIn;
  final User user;

  LandingScreen({this.isLoggedIn, this.callback, this.user});

  @override
  _LandingScreenState createState() => _LandingScreenState(
        callback: this.callback,
        isLoggedIn: this.isLoggedIn,
        user: this.user,
      );
}

class _LandingScreenState extends State<LandingScreen> {
  Function callback;
  bool isLoggedIn;
  User user;
  _LandingScreenState({
    this.callback,
    this.isLoggedIn,
    this.user,
  });

  bool showSignUpForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Moodial',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                  child: Text(
                    showSignUpForm ? 'Sign Up' : 'Log In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                showSignUpForm
                    ? SignUpForm(
                        callback: this.callback,
                        isLoggedIn: this.isLoggedIn,
                        user: this.user,
                      )
                    : LoginForm(
                        callback: this.callback,
                        isLoggedIn: this.isLoggedIn,
                        user: this.user,
                      ),
                Column(
                  children: [
                    Text(
                      showSignUpForm
                          ? 'Already using Moodial?'
                          : 'New to Moodial?',
                    ),
                    OutlinedButton(
                      child: Text(
                        showSignUpForm
                            ? 'Tap here to log in!'
                            : 'Tap here to sign up!',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          showSignUpForm = !showSignUpForm;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
