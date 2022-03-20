import 'package:Moodial/screens/entry_screen.dart';
import 'package:Moodial/services/api.dart';
import 'package:Moodial/widgets/home_screen/add_entry_dial.dart';
import 'package:Moodial/widgets/home_screen/update_entry_form.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

import 'add_entry_form.dart';
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
Future<Checkboxs> getCheckBoxes(String username) async {
  var db = await  mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts.fxnqc.mongodb.net/Test?retryWrites=true&w=majority");
  await db.open();
  var coll = db.collection('user');
  var coll2 = db.collection('TestData');
  var check = await coll2.findOne(mongo.where.eq("name", "test").fields(['counter']));
  int value = check['counter']+1;
  await coll2.updateOne(mongo.where.eq("name", 'test'), mongo.modify.set("counter", value));
  if(Checks.check1==null)
    {
      Checks.check1=false;
    }
  if(Checks.check2==null)
  {
    Checks.check2=false;
  }
  if(Checks.check3==null)
  {
    Checks.check3=false;
  }
  if(Checks.check4==null)
  {
    Checks.check4=false;
  }
  if(Checks.check5==null)
  {
    Checks.check5=false;
  }
  await coll.updateOne(mongo.where.eq("username", username), mongo.modify.set("1check"+value.toString(), Checks.check1));
  await coll.updateOne(mongo.where.eq("username", username), mongo.modify.set("2check"+value.toString(), Checks.check2));
  await coll.updateOne(mongo.where.eq("username", username), mongo.modify.set("3check"+value.toString(), Checks.check3));
  await coll.updateOne(mongo.where.eq("username", username), mongo.modify.set("4check"+value.toString(), Checks.check4));
  await coll.updateOne(mongo.where.eq("username", username), mongo.modify.set("5check"+value.toString(), Checks.check5));
  print("works");

  await db.close();
}

Future<MoodValues> getMoodValues(String username,String value) async {

  var db = await  mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts.fxnqc.mongodb.net/Test?retryWrites=true&w=majority");
  await db.open();
  var coll = db.collection('user');

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
  var val = await coll.findOne(mongo.where.eq("username", username).fields([value]));
    await coll.updateOne(
        mongo.where.eq("username", username), mongo.modify.set("today", formatterToday.format(now)));


    int intvalue;
    String Stringval;
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
    await coll.updateOne(mongo.where.eq("username", username),
        mongo.modify.set(value, Stringval));

  await db.close();

}


class AddEntryButton extends StatefulWidget {
  final int dialState;
  final UniqueKey key;
  final String userToken;
  final Function callback;
  final User user;

  AddEntryButton({
    this.dialState,
    this.key,
    this.userToken,
    this.callback,
    this.user
  });

  @override
  _AddEntryButtonState createState() => _AddEntryButtonState(
        dialState: this.dialState,
        key: this.key,
        userToken: this.userToken,
        callback: this.callback,
        user: this.user
      );
}

class _AddEntryButtonState extends State<AddEntryButton> {
  int dialState;
  UniqueKey key;
  String userToken;
  Function callback;
  User user;

  Map<String, dynamic> formState;

  _AddEntryButtonState({
    this.dialState,
    this.key,
    this.userToken,
    this.callback,
    this.user
  });

  sliderCallback(sliderValue) {
    setState(() {
      this.dialState = sliderValue;
    });
  }

  formCallback(formData) {
    setState(() {
      this.formState = formData;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50.0,
        vertical: 10.0,
      ),
      child: ElevatedButton(
        child: Text('Add Entry'),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Color.fromRGBO(0, 0, 0, 0),
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: Color.fromRGBO(0, 0, 0, 0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              icon: Icon(FeatherIcons.x),
                              color: Colors.white,
                              iconSize: 40.0,
                              onPressed: () {
                                this.callback(false);
                                Navigator.pop(context);
                              }),
                        ),
                        Container(
                          height: 880,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              AddEntryDial(
                                sliderValue: dialState.toDouble(),
                                callback: this.sliderCallback,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now()) +
                                      ' • ' +
                                      DateFormat('H:mm')
                                          .format(DateTime.now())),
                                ),
                              ),
                              AddEntryForm(this.formCallback),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    minimum: EdgeInsets.all(15),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: ElevatedButton(
                        child: Text('SAVE'),
                        onPressed: () {
                          print(Checks.check1);print(Checks.check2);print(Checks.check3);print(Checks.check4);print(Checks.check5);
                          //getCheckBoxes(user.username);

                          if(Checks.check1==true)
                          {
                            getMoodValues(user.username,'games');
                          }
                          if(Checks.check2==true)
                          {
                            getMoodValues(user.username,'work');
                          }
                          if(Checks.check3==true)
                          {
                            getMoodValues(user.username,'sports');
                          }
                          if(Checks.check4==true)
                          {
                            getMoodValues(user.username,'tv');
                          }
                          if(Checks.check5==true)
                          {
                            getMoodValues(user.username,'shopping');
                          }
                          print(dialState);
                          if(dialState==1)
                          {
                            getMoodValues(user.username,'happy');
                          }
                          else if(dialState==2)
                          {
                            getMoodValues(user.username,'sad');
                          }
                          else if(dialState==3)
                          {
                            getMoodValues(user.username,'surpised');
                          }
                          else if(dialState==4)
                          {
                            getMoodValues(user.username,'disgusted');
                          }
                          else if(dialState==5)
                          {
                            getMoodValues(user.username,'angry');
                          }
                          else if(dialState==6)
                          {
                            getMoodValues(user.username,'fearful');
                          }
                          else if(dialState==7)
                          {
                            getMoodValues(user.username,'bad');
                          }
                          formState['mood'] = dialState;
                          if (formState['valid'] == true) {
                            ApiService.postEntry(
                              userToken,
                              formState,
                            ).then((response) {
                              this.callback(false);
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Align(
                                      alignment: Alignment.topCenter,
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Container(
                                            color: Color.fromRGBO(0, 0, 0, 0),
                                            child: Container(
                                              height: 330,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 20.0),
                                                child: ListView(
                                                  children: [
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxHeight: 120,
                                                        maxWidth: 120,
                                                      ),
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/sent.gif'),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'We got it!',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          'Your entry has been successfully sent to our database. You can always come back and make changes or add information when you have time.'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SafeArea(
                                            minimum: EdgeInsets.all(15),
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: 40.0,
                                              child: ElevatedButton(
                                                child: Text('OKAY'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(Theme
                                                                    .of(context)
                                                                .primaryColor)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            });
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor)),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
