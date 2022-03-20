import 'dart:async';
import 'dart:io';

import 'package:Moodial/services/api.dart';
import 'package:Moodial/models/user.dart';
import 'package:Moodial/widgets/home_screen/dial.dart';
import 'package:Moodial/widgets/home_screen/add_entry_button.dart';
import 'package:Moodial/widgets/home_screen/avatar.dart';
import 'package:Moodial/widgets/home_screen/recent_entry_card.dart';
import 'package:Moodial/widgets/navbar.dart';
import 'package:async/async.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../main.dart';
import 'entry_screen.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'note2.dart';
import 'notifition_screen.dart';
DateTime now = new DateTime.now();
DateFormat formatter = new DateFormat('yyyy-MM-dd');
String dateHolder = formatter.format(now);
Future<Date1> getDate(String username) async {

  var db = await  mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts.fxnqc.mongodb.net/Test?retryWrites=true&w=majority");
  await db.open();
  var coll = db.collection('user');
  var date = await coll.findOne(mongo.where.eq("username", username).fields(['date']));
  var entry= await coll.findOne(mongo.where.eq("username", username).fields(['entry']));
  var notification = await coll.findOne(mongo.where.eq("username", username).fields(['notifications']));
  var notificationtimer = await coll.findOne(mongo.where.eq("username", username).fields(['notificationtimer']));
  Something.notifytime = notificationtimer['notificationtimer'];
  var id = await coll.findOne(mongo.where.eq("username", username).fields(['_id']));
  if(id['_id']!=null) {
    if (id['_id'].isEven) {
      await coll.updateOne(
          mongo.where.eq("username", username), mongo.modify.set('ab', "a"));
      Something.ab = "a";
    }
    else {
      await coll.updateOne(
          mongo.where.eq("username", username), mongo.modify.set('ab', "b"));
      Something.ab = "b";
    }
  }

  if(notification["notifications"]==null)
    {
      await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set('notifications',"off"));
      print("notify is undefined set to off");
      Something.notify = "off";
    }
  else if(notification["notifications"]=="off")
    {
      print("notify is  off");
      Something.notify = "off";
    }
  else if(notification["notifications"]=="on")
  {
    print("notify is  on");
    Something.notify = "on";
    print(Something.notify);
  }
  print(dateHolder);
  if(date["date"]==dateHolder)
    {
      await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set('date',dateHolder));
      await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set('entry',"yes"));
      Something.today="yes";

    }
  else
  {
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set('entry',"no"));
    Something.today="no";

  }
  print("is entry" + entry["entry"]);
  await db.close();
  return Date1.fromJson(date);
}
class Date1{
  final String today;
  final String check;
  final String notification;
  Date1({
    @required this.today,this.check,this.notification
  });

  factory Date1.fromJson(Map<String, dynamic> json) {
    return Date1(
        today: json['date'],
        notification:json['notifications'],
        check: json['entry']
    );
  }
}
Future<UserAvatar1> getAvatar1(String username) async {

  var db = await  mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts.fxnqc.mongodb.net/Test?retryWrites=true&w=majority");
  await db.open();
  var coll = db.collection('user');
  var avatar = await coll.findOne(mongo.where.eq("username", username).fields(['avatar']));
  print("is avatar" +avatar["avatar"]);
  await db.close();
  return UserAvatar1.fromJson(avatar);
}
class UserAvatar1{
  final String picture;
  UserAvatar1({
    @required this.picture
  });

  factory UserAvatar1.fromJson(Map<String, dynamic> json) {
    return UserAvatar1(
        picture: json['avatar']
    );
  }
}
class HomeScreen extends StatefulWidget {
  final User user;
  final Function navPosCallback;
  HomeScreen({
    this.user,
    this.navPosCallback,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState(
        user: this.user,
        navPosCallback: this.navPosCallback,
      );
}

class _HomeScreenState extends State<HomeScreen> {
  String value;
  var avatar;
  var date;
  static final DateTime now = DateTime.now();
  static final DateFormat formatter =  DateFormat('yyyy-MM-dd');
  String dateHolder = formatter.format(now);
  void initState() {
    RenderErrorBox.backgroundColor = Colors.white;
    RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
    if(value==null)
    {
      value="test";
    }
    print(user.username);
    avatar=getAvatar1(user.username);
    date=getDate(user.username);
    Something.username=user.username;
    Timer(Duration(seconds: 3), () {
      scheduleAlarm();
    });
  }


  Widget pic(){
    return FutureBuilder<UserAvatar1>(
        future: avatar,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return CircleAvatar(
                radius:70.0,
                backgroundColor: Colors.greenAccent,
                child: CircleAvatar(
                    radius:65.0,
                    backgroundColor: Colors.green,
                    child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: FileImage(File(snapshot.data.picture))
                    )
                )
            );
          else
            return  CircleAvatar(
                radius:70.0,
                backgroundColor: Colors.greenAccent,
                child: CircleAvatar(
                    radius:65.0,
                    backgroundColor: Colors.green,
                    child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage("https://i.imgur.com/BlJEjuV.png")
                    )
                )
            );// or some other placeholder
        });
  }
  int _currentTab = 0;
  int _dialState = 1;
  bool _firstLoadFlag = true;
  User user;
  Function navPosCallback;

  AsyncMemoizer _memoizer = AsyncMemoizer();

  _HomeScreenState({
    this.user,
    this.navPosCallback,
  });

  dialCallback(dialState) {
    setState(() {
      _dialState = dialState;
    });
  }

  modalCallback(flag) {
    setState(() {
      _firstLoadFlag = flag;
    });
  }

  _fetchEntries() {
    return this._memoizer.runOnce(() async {
      return ApiService.getEntryList(user.userToken);
    });
  }

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
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                  child: Text(
                    user.username != null
                        ? 'Good to see you, ' + user.username + '!'
                        : 'Welcome to Moodial!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                  child: Text('How are you feeling right now?'),
                ),
                pic(),
                /*Avatar(
                  dialState: _dialState,
                  key: UniqueKey(),
                ),*/

                Dial(
                  callback: this.dialCallback,
                ),

                    AddEntryButton(

                      dialState: this._dialState,
                      key: UniqueKey(),
                      userToken: this.user.userToken,
                      user: this.user,
                      callback: this.modalCallback,

                    ),




                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0, 0),
                  child: Text('Recent Entries',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                FutureBuilder(
                  future: _firstLoadFlag
                      ? _fetchEntries()
                      : ApiService.getEntryList(user.userToken),
                  builder: (context, snapshot) {
                    final entryList = snapshot.data;

                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null &&
                        entryList.length < 5 &&
                        entryList.length > 0) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: entryList.reversed
                              .map<Widget>(
                                (entry) => RecentEntryCard(
                                  entry: entry,
                                  userToken: user.userToken,
                                  callback: this.modalCallback,
                                  user: this.user,
                                ),
                              )
                              .toList(),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.data != null &&
                        entryList.length >= 5) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: entryList.reversed
                              .take(5)
                              .map<Widget>(
                                (entry) => RecentEntryCard(
                                  entry: entry,
                                  userToken: user.userToken,
                                  callback: this.modalCallback,
                                  user: this.user
                                ),
                              )
                              .toList(),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        (snapshot.data == null || snapshot.data.length == 0)) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 5.0, 0, 0),
                        child: Text(
                            'Add your first entry to see recent entries here!'),
                      );
                    } else if (snapshot.hasError) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 5.0, 0, 0),
                        child: Text('Error: ' + snapshot.error.toString()),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                )
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
  void scheduleAlarm() async{
    print(Something.notifytime);
    if(Something.notify=="on") {
      if(Something.today=="yes") {
        int hours =0;
        print("yes");
        if(Something.notifytime=="12AM")
          {
            hours=0;
          }
        else if(Something.notifytime=="1AM")
        {
          hours=1;
        }
        else if(Something.notifytime=="2AM")
        {
          hours=2;
        }
        else if(Something.notifytime=="3AM")
        {
          hours=3;
        }
        else if(Something.notifytime=="4AM")
        {
          hours=4;
        }
        else if(Something.notifytime=="5AM")
        {
          hours=5;
        }
        else if(Something.notifytime=="6AM")
        {
          hours=6;
        }
        else if(Something.notifytime=="7AM")
        {
          hours=7;
        }
        else if(Something.notifytime=="8AM")
        {
          hours=8;
        }
        else if(Something.notifytime=="9AM")
        {
          hours=9;
        }
        else if(Something.notifytime=="10AM")
        {
          hours=10;
        }
        else if(Something.notifytime=="11AM")
        {
          hours=11;
        }
        else if(Something.notifytime=="12AM")
        {
          hours=12;
        }
        else if(Something.notifytime=="1PM")
        {
          hours=13;
        }
        else if(Something.notifytime=="2PM")
        {
          hours=14;
        }
        else if(Something.notifytime=="3PM")
        {
          hours=15;
        }
        else if(Something.notifytime=="4PM")
        {
          hours=16;
        }
        else if(Something.notifytime=="5PM")
        {
          hours=17;
        }
        else if(Something.notifytime=="6PM")
        {
          hours=18;
        }
        else if(Something.notifytime=="7PM")
        {
          hours=19;
        }
        else if(Something.notifytime=="8PM")
        {
          hours=20;
        }
        else if(Something.notifytime=="9PM")
        {
          hours=21;
        }
        else if(Something.notifytime=="10PM")
        {
          hours=22;
        }
        else if(Something.notifytime=="11PM")
        {
          hours=23;
        }

        var scheduledNotificationDateTime = DateTime(now.year, now.month, now.day + 1, hours);
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'alarm_notif',
          'alarm_notif',
          'Channel for Alarm notification',
          icon: 'moodial',
          largeIcon: DrawableResourceAndroidBitmap('moodial'),
        );

        var iOSPlatformChannelSpecifics = IOSNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true);
        var platformChannelSpecifics = NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: iOSPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.schedule(
            0,
            'Moodial',
            'Moodial is ready to be updated',
            scheduledNotificationDateTime,
            platformChannelSpecifics);
      }
    }
  }
}
class Something {
 static String today;
 static String username;
 static String notify;
 static String notifytime;
 static String ab;
}