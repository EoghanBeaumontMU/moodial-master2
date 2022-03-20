import 'package:Moodial/models/entry.dart';

class User {
  final String loginStatus;
  final String userToken;
  String username;
  Entry lastEntry;
  String avatarLink;


  User({
    this.loginStatus,
    this.userToken,
    this.username,
    this.lastEntry,
    this.avatarLink,

  });

  // ignore: empty_constructor_bodies
  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      loginStatus: json['message'],
      userToken: json['JWT'],
    );
  }
}
