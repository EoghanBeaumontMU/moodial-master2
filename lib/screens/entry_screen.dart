// ignore: file_names
import 'dart:io';
import 'package:Moodial/screens/chartsback_screen.dart';
import 'package:Moodial/services/api.dart';
import 'package:Moodial/models/user.dart';
import 'package:Moodial/widgets/navbar.dart';
import 'package:async/async.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'home_screen.dart';
final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy');
final DateFormat formatterMonth = DateFormat('MM');
final DateFormat formatterDay = DateFormat('DD');
String year1 = formatter.format(now);
String month1 = formatterMonth.format(now);
String day1 = formatterDay.format(now);
final DateFormat formatterToday  = new DateFormat('yyyy-MM-dd');
String today = formatterToday.format(now);
String formattedDate = formatter.format(now);
String alertbox;
Future<MoodValues> getMoodValues(String username,String value) async {

  var db = await  mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts.fxnqc.mongodb.net/Test?retryWrites=true&w=majority");
  await db.open();
  var coll = db.collection('user');
  print("date=" +formattedDate);
  print("month=" +month1);
  if(month1=='11')
  {
    month1='November';
  }
  else if(month1=='12')
  {
    month1='December';
  }
  else if(month1=='01')
  {
    month1='January';
  }
  else if(month1=='02')
  {
    month1='February';
  }else if(month1=='03')
  {
    month1='March';
  }else if(month1=='04')
  {
    month1='April';
  }
  else if(month1=='05')
  {
    month1='May';
  }
  else if(month1=='06')
  {
    month1='June';
  }
  else if(month1=='07')
  {
    month1='July';
  }
  else if(month1=='08')
  {
    month1='August';
  }else if(month1=='09')
  {
    month1='September';
  }
  else if(month1=='10')
  {
    month1='October';
  }
  value=value+month1+year1;
  print(value);
  var val = await coll.findOne(mongo.where.eq("username", username).fields([value]));
  var today = await coll.findOne(mongo.where.eq("username", username).fields(['today']));
  if(today["today"]!=formatterToday.format(now)) {
    await coll.updateOne(
        mongo.where.eq("username", username), mongo.modify.set("today", formatterToday.format(now)));


    int intvalue;
    String Stringval;
    print(val);
    if (val[value] == null) {
      intvalue = 0;
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("games" + month1 + year1, "0"));
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("happy" + month1 + year1, "0"));
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("sad" + month1 + year1, "0"));
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("surprised" + month1 + year1, "0"));
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("angry" + month1 + year1, "0"));
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("bad" + month1 + year1, "0"));
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("fearful" + month1 + year1, "0"));
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("disgusted" + month1 + year1, "0"));
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("shopping" + month1 + year1, "0"));
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("work" + month1 + year1, "0"));
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("tv" + month1 + year1, "0"));
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("sports" + month1 + year1, "0"));
      await coll.updateOne(mongo.where.eq("username", username),
          mongo.modify.set("tv" + month1 + year1, "0"));
    }
    else {
      intvalue = int.parse(val[value]);
    }
    intvalue = intvalue + 1;
    Stringval = intvalue.toString();
    print(val[value]);
    await coll.updateOne(mongo.where.eq("username", username),
        mongo.modify.set(value, Stringval));

    print(month1);
  }
  else
    {
      print("already entered");

    }

  await db.close();
}

class EntryScreen extends StatefulWidget {

  final User user;

  EntryScreen( {
    this.user
  });


  @override
  _EntryScreenState createState() => _EntryScreenState(
    user: this.user
  );
}

class _EntryScreenState extends State<EntryScreen> {

  User user;
  _EntryScreenState({
    this.user,
  });
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;
  bool isChecked7 = false;
  bool isChecked8 = false;
  bool isChecked9 = false;
  bool isChecked10= false;
  bool isChecked11= false;
  bool isChecked12= false;


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
      return Colors.red;
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          brightness: Brightness.dark,
        ),
        body: Container(
            child: Column(
                children: <Widget>[
                      Text(today,textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),

                  SizedBox(height: 30),
                  Text("Activities done",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.gamepad ,
                        color: Colors.black,
                        size: 48.0,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.work,
                        color: Colors.black,
                        size: 48.0,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.sports_soccer,
                        color: Colors.black,

                        size: 48.0,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.tv_sharp,
                        color: Colors.black,
                        size: 48.0,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                        size: 48.0,
                      ),
                    ],
                  ),
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
                          value: isChecked3,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked3 = value;
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
                        value: isChecked4,
                        onChanged: (bool value) {
                          setState(() {
                            isChecked4 = value;
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
                          value: isChecked5,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked5 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text("Mood",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),

                  ButtonBar(
                    alignment: MainAxisAlignment.center,

                    children: [
                      SvgPicture.asset(
                        'assets/images/happy-emoji.svg',
                        width: 48.0,
                        height: 48.0,
                      ),
                      SizedBox(width: 16),
                      SvgPicture.asset(
                        'assets/images/surprised-emoji.svg',
                        width: 48.0,
                        height: 48.0,
                      ),
                      SizedBox(width: 16),
                      SvgPicture.asset(
                        'assets/images/angry-emoji.svg',
                        width: 48.0,
                        height: 48.0,
                      ),
                      SizedBox(width: 16),
                      SvgPicture.asset(
                        'assets/images/bad-emoji.svg',
                        width: 48.0,
                        height: 48.0,
                      ),
                      SizedBox(width: 16),
                      SvgPicture.asset(
                        'assets/images/sad-emoji.svg',
                        width: 48.0,
                        height: 48.0,
                      ),

                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 2.5,
                        child:Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: isChecked6,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked6 = value;
                              isChecked7 = false;
                              isChecked8 = false;
                              isChecked9= false;
                              isChecked10 = false;
                              isChecked11 = false;
                              isChecked12 = false;
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
                          value: isChecked7,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked7 = value;
                              isChecked6 = false;
                              isChecked8 = false;
                              isChecked9= false;
                              isChecked10 = false;
                              isChecked11 = false;
                              isChecked12 = false;

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
                          value: isChecked8,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked8 = value;
                              isChecked6 = false;
                              isChecked7 = false;
                              isChecked9= false;
                              isChecked10 = false;
                              isChecked11 = false;
                              isChecked12 = false;
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
                          value: isChecked9,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked9 = value;
                              isChecked6 = false;
                              isChecked7 = false;
                              isChecked8 = false;
                              isChecked10 = false;
                              isChecked11 = false;
                              isChecked12 = false;
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
                          value: isChecked10,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked10 = value;
                              isChecked6 = false;
                              isChecked7 = false;
                              isChecked8 = false;
                              isChecked9= false;
                              isChecked11 = false;
                              isChecked12 = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                    SvgPicture.asset(
                    'assets/images/disgusted-emoji.svg',
                    width: 48.0,
                    height: 48.0,
                  ),
                      SizedBox(width: 16),
                       SvgPicture.asset(
                        'assets/images/fearful-emoji.svg',
                         width: 48.0,
                        height: 48.0,
                        ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 2.5,
                        child:Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: isChecked11,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked6 = false;
                              isChecked7 = false;
                              isChecked8 = false;
                              isChecked9= false;
                              isChecked10 = false;
                              isChecked11 = value;
                              isChecked12 = false;
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
                          value: isChecked12,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked7 = false;
                              isChecked6 = false;
                              isChecked8 = false;
                              isChecked9= false;
                              isChecked10 = false;
                              isChecked11 = false;
                              isChecked12 = value;

                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 100),
                      Container(child: ElevatedButton(
                          child: const Text('<'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            onPrimary: Colors.white,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }

                      )
                      ),
                      SizedBox(width: 30),
                      Container(alignment: Alignment.bottomRight,child: ElevatedButton(
                          child: const Text('add entry'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            onPrimary: Colors.white,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            if(isChecked1!=false)
                            {
                              getMoodValues(user.username,'games');
                            }
                            if(isChecked2!=false)
                            {
                              getMoodValues(user.username,'work');
                            }
                            if(isChecked3!=false)
                            {
                              getMoodValues(user.username,'sports');
                            }
                            if(isChecked4!=false)
                            {
                              getMoodValues(user.username,'tv');
                            }
                            if(isChecked5!=false)
                            {
                              getMoodValues(user.username,'shopping');
                            }
                            if(isChecked6!=false)
                            {
                              getMoodValues(user.username,'happy');
                            }
                            if(isChecked7!=false)
                            {
                              getMoodValues(user.username,'surprised');
                            }
                            if(isChecked8!=false)
                            {
                              getMoodValues(user.username,'angry');
                            }
                            if(isChecked9!=false)
                            {
                              getMoodValues(user.username,'bad');
                            }
                            if(isChecked10!=false)
                            {
                              getMoodValues(user.username,'sad');
                            }
                            if(isChecked11!=false)
                            {
                              getMoodValues(user.username,'disgusted');
                            }
                            if(isChecked12!=false)
                            {
                              getMoodValues(user.username,'fearful');
                            }
                            Navigator.pop(context);

                          }

                      )
                      )


                    ],
                  ),
                ]

        )
        ));

  }
}
