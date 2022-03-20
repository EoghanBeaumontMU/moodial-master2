import 'package:Moodial/models/user.dart';
import 'package:Moodial/services/mood_props.dart';
import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  final User user;
  final int dialState;
  final UniqueKey key;

  Avatar({this.user, this.dialState, this.key});

  @override
  _AvatarState createState() =>
      _AvatarState(user: this.user, dialState: this.dialState, key: this.key);
}

class _AvatarState extends State<Avatar> {
  User user;
  int dialState;
  UniqueKey key;

  _AvatarState({this.user, this.dialState, this.key});

  final String defaultAvatarLink =
      'https://static.wikia.nocookie.net/avatar/images/7/79/Pilot_-_Aang.png/revision/latest/top-crop/width/360/height/360?cb=20120311133235';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Center(
        child: SizedBox(
          width: 200,
          height: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(100),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 115,
                    height: 115,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(150),
                      shape: BoxShape.circle,
                    ),
                  ),
                  user.avatarLink == null
                      ? CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                        )
                      : CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(
                            user.avatarLink,
                          ),
                        ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(3, 3), // changes position of shadow
                        ),
                      ]),
                      child: MoodProps.moodEmoji(dialState),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
