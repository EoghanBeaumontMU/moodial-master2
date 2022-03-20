import 'package:Moodial/services/api.dart';
import 'package:Moodial/models/user.dart';
import 'package:Moodial/widgets/navbar.dart';
import 'package:Moodial/widgets/stats_screen/food_chart.dart';
import 'package:Moodial/widgets/stats_screen/mood_history_chart.dart';
import 'package:Moodial/widgets/stats_screen/resources.dart';
import 'package:Moodial/widgets/stats_screen/sleep_iritability_chart.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:Moodial/screens/chartsback_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../main.dart';

Future<MoodValues> getNotifyalues(String username,bool switched,bool switched2,String dropdown) async {

  var db = await  mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts.fxnqc.mongodb.net/Test?retryWrites=true&w=majority");
  await db.open();
  var coll = db.collection('user');
  await coll.updateOne(mongo.where.eq("username", username), mongo.modify.set("notificationtimer",dropdown));
  if(switched ==true)
  {
    print("turn off");
    await coll.updateOne(mongo.where.eq("username", username), mongo.modify.set("notifications","off"));
  }
  else if(switched2==true)
  {
    print("turn on");
    await coll.updateOne(mongo.where.eq("username", username), mongo.modify.set("notifications","on"));
  }

  await db.close();
}

// ignore: camel_case_types
class Note2Screen extends StatefulWidget {
  final User user;
  final Function navPosCallback;

  Note2Screen({
    this.user,
    this.navPosCallback,
  });

  @override
  _Note2ScreenState createState() => _Note2ScreenState(
    user: this.user,
    navPosCallback: this.navPosCallback,
  );
}

class _Note2ScreenState extends State<Note2Screen> {
  User user;
  Function navPosCallback;
  bool isChecked1 = false;
  bool isChecked2 = false;
  String dropdownValue ='1AM';
  _Note2ScreenState({
    this.user,
    this.navPosCallback,
  });
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
      return Colors.blue;
    }
    return Scaffold(
      body: Container(
          child: Container(

              child: Column(
                  children: <Widget>[
                    SizedBox(height: (MediaQuery.of(context).size.height/6)),
                    Row(children: [
                      Container(alignment: Alignment.topLeft,
                        child:Padding(
                            padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                              child: const Text('<'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                onPrimary: Colors.white,
                                onSurface: Colors.grey,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          )
                          ),
                      ),
                      SizedBox(width:5.0),
                      Container(alignment: Alignment.center,
                        child: Text('Turn on or off notification',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ]
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height/6)),
                Text('off            on',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,),textAlign:TextAlign.center,),
        ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 2.5,
                child:Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked1,
                  onChanged: (bool value) {
                    setState(() {
                      isChecked1 = value;
                      isChecked2=false;
                    });
                  },
                ),
              ),
              SizedBox(width: 16),
              Transform.scale(
                scale: 2.5,
                child:Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked2,
                  onChanged: (bool value) {
                    setState(() {
                      isChecked2 = value;
                      isChecked1 = false;

                    });
                  },
                ),
              ),
            ],
        ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.blue),
                      underline: Container(
                        height: 2,
                        color: Colors.blueAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['1AM', '2AM', '3AM', '4AM','5AM','6AM','7AM','8AM','9AM','10AM','11AM','12pm','1PM','2PM','3pm','4pm','5pm','6pm','7pm','8pm','9pm','10pm','11pm','12am']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Container(alignment: Alignment.topCenter,
                      child:Padding(
                          padding: EdgeInsets.all(15),
                          child: ElevatedButton(
                              child: const Text('Enter'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                onPrimary: Colors.white,
                                onSurface: Colors.grey,
                              ),
                              onPressed: () {
                                getNotifyalues(user.username,isChecked1,isChecked2,dropdownValue);
                                scheduleAlarm();
                                Navigator.pop(context);
                              }
                          )
                      ),
                    ),
                  ]
              )

          )
      ),

    );


  }
  void scheduleAlarm() async{
    if(isChecked2 = true) {
      int hours =0;
      print("yes");
      if(dropdownValue=="12AM")
      {
        hours=0;
      }
      else if(dropdownValue=="1AM")
      {
        hours=1;
      }
      else if(dropdownValue=="2AM")
      {
        hours=2;
      }
      else if(dropdownValue=="3AM")
      {
        hours=3;
      }
      else if(dropdownValue=="4AM")
      {
        hours=4;
      }
      else if(dropdownValue=="5AM")
      {
        hours=5;
      }
      else if(dropdownValue=="6AM")
      {
        hours=6;
      }
      else if(dropdownValue=="7AM")
      {
        hours=7;
      }
      else if(dropdownValue=="8AM")
      {
        hours=8;
      }
      else if(dropdownValue=="9AM")
      {
        hours=9;
      }
      else if(dropdownValue=="10AM")
      {
        hours=10;
      }
      else if(dropdownValue=="11AM")
      {
        hours=11;
      }
      else if(dropdownValue=="12AM")
      {
        hours=12;
      }
      else if(dropdownValue=="1PM")
      {
        hours=13;
      }
      else if(dropdownValue=="2PM")
      {
        hours=14;
      }
      else if(dropdownValue=="3PM")
      {
        hours=15;
      }
      else if(dropdownValue=="4PM")
      {
        hours=16;
      }
      else if(dropdownValue=="5PM")
      {
        hours=17;
      }
      else if(dropdownValue=="6PM")
      {
        hours=18;
      }
      else if(dropdownValue=="7PM")
      {
        hours=19;
      }
      else if(dropdownValue=="8PM")
      {
        hours=20;
      }
      else if(dropdownValue=="9PM")
      {
        hours=21;
      }
      else if(dropdownValue=="10PM")
      {
        hours=22;
      }
      else if(dropdownValue=="11PM")
      {
        hours=23;
      }

      var scheduledNotificationDateTime = DateTime(now.year, now.month, now.day, hours);
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
