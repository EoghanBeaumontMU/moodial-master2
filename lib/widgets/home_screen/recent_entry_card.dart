import 'package:Moodial/models/user.dart';
import 'package:Moodial/screens/ScrollChart.dart';
import 'package:Moodial/services/api.dart';
import 'package:Moodial/models/entry.dart';
import 'package:Moodial/services/mood_props.dart';
import 'package:Moodial/widgets/home_screen/add_entry_dial.dart';
import 'package:Moodial/widgets/home_screen/add_entry_form.dart';
import 'package:Moodial/widgets/home_screen/update_entry_form.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy');
final DateFormat formatterMonth = DateFormat('MM');
final DateFormat formatterDay = DateFormat('DD');
String year1 = formatter.format(now);
String month1 = formatterMonth.format(now);
String day1 = formatterDay.format(now);
final DateFormat formatterToday  = new DateFormat('yyyy-MM-dd');
String today = formatterToday.format(now);
bool prev1 = Checks2.check1;
bool prev2 = Checks2.check2;
bool prev3 = Checks2.check3;
bool prev4 = Checks2.check4;
bool prev5 = Checks2.check5;
String formattedDate = formatter.format(now);
String alertbox;
Future<MoodValues>getMoodValues(String username,String value,bool add) async {

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
  print(add);
  if(add==true) {
    intvalue = intvalue + 1;
  }
  else if(add==false)
    {
      print(value +" -1");
      intvalue = intvalue - 1;
      if(intvalue<0)
        {
          intvalue=0;
        }
    }
  else
    {
      print("values");
      print(prev1);
      print(Checks2.check1);
      if(prev1=false)
        {
          if(Checks2.check1=true)
            {
              var val = await coll.findOne(mongo.where.eq("username", username).fields(["games"+month1+year1]));
              int check= int.parse(val["games"+month1+year1])+1;
              if(check<0)
              {
                check=0;
              }
              String fin = check.toString();
              await coll.updateOne(mongo.where.eq("username", username),
                  mongo.modify.set("games"+month1+year1,fin));
            }
        }
      if(prev1=true)
      {
        if(Checks2.check1=false)
        {
          var val = await coll.findOne(mongo.where.eq("username", username).fields(["games"+month1+year1]));
          int check= int.parse(val["games"+month1+year1])-1;
          if(check<0)
            {
              check=0;
            }
          String fin = check.toString();
          await coll.updateOne(mongo.where.eq("username", username),
              mongo.modify.set("games"+month1+year1,fin));
        }
      }
      if(prev2=false)
      {
        if(Checks2.check2=true)
        {
          var val = await coll.findOne(mongo.where.eq("username", username).fields(["work"+month1+year1]));
          int check= int.parse(val["work"+month1+year1])+1;
          if(check<0)
          {
            check=0;
          }
          String fin = check.toString();
          await coll.updateOne(mongo.where.eq("username", username),
              mongo.modify.set("work"+month1+year1,fin));
        }
      }
      if(prev2=true)
      {
        if(Checks2.check2=false)
        {
          var val = await coll.findOne(mongo.where.eq("username", username).fields(["work"+month1+year1]));
          int check= int.parse(val["work"+month1+year1])-1;
          if(check<0)
          {
            check=0;
          }
          String fin = check.toString();
          print("changed");
          await coll.updateOne(mongo.where.eq("username", username),
              mongo.modify.set("work"+month1+year1,fin));
        }
      }
      if(prev3=true)
      {
        if(Checks2.check3=false)
        {
          var val = await coll.findOne(mongo.where.eq("username", username).fields(["sports"+month1+year1]));
          int check= int.parse(val["sports"+month1+year1])-1;
          if(check<0)
          {
            check=0;
          }
          String fin = check.toString();
          print("changed");
          await coll.updateOne(mongo.where.eq("username", username),
              mongo.modify.set("sports"+month1+year1,fin));
        }
      }
      if(prev3=false)
      {
        if(Checks2.check3=true)
        {
          var val = await coll.findOne(mongo.where.eq("username", username).fields(["sports"+month1+year1]));
          int check= int.parse(val["sports"+month1+year1])+1;
          if(check<0)
          {
            check=0;
          }
          String fin = check.toString();
          print("changed");
          await coll.updateOne(mongo.where.eq("username", username),
              mongo.modify.set("sports"+month1+year1,fin));
        }
      }
      if(prev4=true)
      {
        if(Checks2.check4=false)
        {
          var val = await coll.findOne(mongo.where.eq("username", username).fields(["tv"+month1+year1]));
          int check= int.parse(val["tv"+month1+year1])-1;
          if(check<0)
          {
            check=0;
          }
          String fin = check.toString();
          print("changed");
          await coll.updateOne(mongo.where.eq("username", username),
              mongo.modify.set("tv"+month1+year1,fin));
        }
      }
      if(prev4=false)
      {
        if(Checks2.check4=true)
        {
          var val = await coll.findOne(mongo.where.eq("username", username).fields(["tv"+month1+year1]));
          int check= int.parse(val["tv"+month1+year1])+1;
          String fin = check.toString();
          await coll.updateOne(mongo.where.eq("username", username),
              mongo.modify.set("tv"+month1+year1,fin));
        }
      }
      if(prev5=false)
      {
        if(Checks2.check5=true)
        {
          var val = await coll.findOne(mongo.where.eq("username", username).fields(["shopping"+month1+year1]));
          int check= int.parse(val["shopping"+month1+year1])+1;
          if(check<0)
          {
            check=0;
          }
          String fin = check.toString();
          print("changed");
          await coll.updateOne(mongo.where.eq("username", username),
              mongo.modify.set("shopping"+month1+year1,fin));
        }
      }

      if(prev5=true)
      {
        if(Checks2.check5=false)
        {
          var val = await coll.findOne(mongo.where.eq("username", username).fields(["shopping"+month1+year1]));
          int check= int.parse(val["shopping"+month1+year1])-1;
          String fin = check.toString();
          await coll.updateOne(mongo.where.eq("username", username),
              mongo.modify.set("shopping"+month1+year1,fin));
        }
      }
    }
  Stringval = intvalue.toString();
  await coll.updateOne(mongo.where.eq("username", username),
      mongo.modify.set(value, Stringval));

  await db.close();

}

class RecentEntryCard extends StatefulWidget {
  final Entry entry;
  final String userToken;
  final Function callback;
  final User user;

  RecentEntryCard({
    this.entry,
    this.userToken,
    this.callback,
    this.user
  });

  @override
  _RecentEntryCardState createState() => _RecentEntryCardState(
        entry: this.entry,
        userToken: this.userToken,
        callback: this.callback,
        user: this.user
      );
}

class _RecentEntryCardState extends State<RecentEntryCard> {
  Entry entry;
  String userToken;
  Function callback;
  User user;
  bool prev1;
  bool prev2;
  bool prev3;
  bool prev4;
  bool prev5;

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  _RecentEntryCardState({
    this.entry,
    this.userToken,
    this.callback,
    this.user,
  });

  Map<String, dynamic> formState = {};
  int dialState;
  int previous;
  bool _overwritten = false;
  void initState() {
    super.initState();
    print("entry mood is ");
    print(entry.mood);
    previous = entry.mood;
    prev1 = Checks2.check1;
    prev2 = Checks2.check2;
    prev3 = Checks2.check3;
    prev4 = Checks2.check4;
    prev5 = Checks2.check5;
  }
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

  void overwriteDialState() {
    if (!_overwritten) {
      setState(() {
        dialState = entry.mood;
      });
      _overwritten = !_overwritten;
    }
  }

  showModal() {
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
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(DateFormat('dd-MM-yyyy')
                                    .format(DateTime.now()) +
                                ' • ' +
                                DateFormat('H:mm').format(DateTime.now())),
                          ),
                        ),
                        UpdateEntryForm(this.formCallback, this.entry,this.user),
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
                  child: Text('UPDATE'),
                  onPressed: () {
                      getCheckbox(user.username,entry.id);
                      getMoodValues(user.username,'happy',null);
                    if(dialState==1)
                    {
                      print("dialstate is 1");
                      getMoodValues(user.username,'happy',true);
                    }
                    if(dialState==2)
                    {
                      print("dialstate is 2");
                      getMoodValues(user.username,'sad',true);
                    }
                     if(dialState==3)
                    {
                      print("dialstate is 3");
                      getMoodValues(user.username,'surpised',true);
                    }
                     if(dialState==4)
                    {
                      print("dialstate is 4");
                      getMoodValues(user.username,'disgusted',true);
                    }
                    if(dialState==5)
                    {
                      print("dialstate is 5");
                      getMoodValues(user.username,'angry',true);
                    }
                     if(dialState==6)
                    {
                      print("dialstate is 6");
                      getMoodValues(user.username,'fearful',true);
                    }
                     if(dialState==7)
                    {
                      print("dialstate is 7");
                      getMoodValues(user.username,'bad',true);
                    }
                    if(previous==1)
                    {
                      print("previous is 1");
                      getMoodValues(user.username,'happy',false);
                    }
                     if(previous==2)
                    {
                      print("previous is 2");
                      getMoodValues(user.username,'sad',false);
                    }
                     if(previous==3)
                    {
                      print("previous is 3");
                      getMoodValues(user.username,'surpised',false);
                    }
                     if(previous==4)
                    {
                      print("previous is 4");
                      getMoodValues(user.username,'disgusted',false);
                    }
                    if(previous==5)
                    {
                      print("previous is 5");
                      getMoodValues(user.username,'angry',false);
                    }
                    if(previous==6)
                    {
                      print("previous is 6");
                      getMoodValues(user.username,'fearful',false);
                    }
                     if(previous==7)
                    {
                      print("previous is 7");
                      getMoodValues(user.username,'bad',false);
                    }
                    formState['mood'] = dialState;
                    if (formState['valid'] == true) {
                      ApiService.updateEntry(
                        userToken,
                        formState,
                        entry.id,
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          child: ListView(
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
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
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'We got it!',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    'Your updates have been successfully sent to our database. You can always come back and make changes or add information when you have time.'),
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
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Theme.of(context)
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
  }

  @override
  Widget build(BuildContext context) {
    overwriteDialState();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        //onTap: () => showModal(),
        child: Container(
          width: double.infinity,
          height: 150,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 15.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color:
                              MoodProps.moodColor(entry.mood).withOpacity(0.7),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                        child: Container(
                          child: MoodProps.moodEmoji(entry.mood),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MoodProps.moodValueToString(entry.mood),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                          Text(
                            DateFormat('dd-MM-yyyy')
                                .format(dateFormat.parse(entry.date)),
                          ),
                          SizedBox(height: 20.0),
                          /*TextButton.icon(
                            onPressed: () {
                              showModal();
                            },
                            label: Text(
                              'View/Edit',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            icon: Icon(
                              FeatherIcons.edit,
                              color: Theme.of(context).primaryColor,
                            ),

                          ),*/
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 130),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Medication:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(entry.medication.name +
                                ' - ' +
                                entry.medication.dose),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Diet:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(entry.diet.food + ' - ' + entry.diet.amount),
                          ],
                        ),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

