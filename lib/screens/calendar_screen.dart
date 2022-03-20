import 'package:Moodial/services/api.dart';
import 'package:Moodial/models/user.dart';
import 'package:Moodial/services/mood_props.dart';
import 'package:Moodial/widgets/calendar_screen/calendar_carousel.dart';
import 'package:Moodial/widgets/navbar.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:Moodial/screens/chartsback_screen.dart';

import 'home_screen.dart';
import 'note2.dart';
import 'notifition_screen.dart';
class CalendarScreen extends StatefulWidget {
  final User user;
  final Function navPosCallback;

  CalendarScreen({
    this.user,
    this.navPosCallback,
  });

  @override
  _CalendarScreenState createState() => _CalendarScreenState(
        user: this.user,
        navPosCallback: this.navPosCallback,
      );
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _currentTab = 2;
  User user;
  Function navPosCallback;
  _CalendarScreenState({
    this.user,
    this.navPosCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Tooltip(
                  message: 'No new notifications',
                  child: IconButton(
                      icon: const Icon(Icons.notifications),
                      color: Colors.white,
                      onPressed: () {
                        print("Something.ab =" + Something.ab);
                        if(Something.ab == "a") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                Note2Screen(user: this.user,
                                  navPosCallback: this.navPosCallback,)),
                          );
                        }
                        else if (Something.ab=="b")
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  NotificationScreen(user: this.user,
                                    navPosCallback: this.navPosCallback,))
                          );
                        }
                      }
                  ),

                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Calendar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      Container(
                        height: 390,
                        width: double.infinity,
                        child: FutureBuilder(
                            future: ApiService.getEntryList(user.userToken),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.data != null) {
                                return Calendar(snapshot.data);
                              } else if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.data == null) {
                                return Calendar(null);
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getIndicator(1, 'Happy'),
                                getIndicator(5, 'Angry')
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getIndicator(2, 'Sad'),
                                getIndicator(6, 'Fearful')
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getIndicator(3, 'Surprised'),
                                getIndicator(7, 'Bad')
                              ],
                            ),
                            getIndicator(4, 'Disgusted'),
                          ],
                        ),
                      ),

                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FutureBuilder(
                            future: ApiService.getEntryList(user.userToken),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.data == null ||
                                    snapshot.data.length == 0) {
                                  return Text(
                                    'Make an entry to see it on the calendar!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  );
                                } else if (snapshot.data.length == 1) {
                                  return Text(
                                    'Congrats on your first entry!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    'You\'re on a roll with ' +
                                        snapshot.data.length.toString() +
                                        ' entries so far!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  );
                                }
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 220,
                              child: Text(
                                  'Your mood analytics will become more accurate and useful with each entry. You\'re doing great by keeping up with your entries!'),
                            ),
                          ),
                          Expanded(
                            child: Image(
                              image: AssetImage(
                                  'assets/images/undraw_visual_data.png'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: NavBar(
        currentTab: _currentTab,
        callback: navPosCallback,

      ),
    );
  }

  Widget getIndicator(value, label) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          child: MoodProps.moodEmoji(value),
        ),
        SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            color: Color(0xff7589a2),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
