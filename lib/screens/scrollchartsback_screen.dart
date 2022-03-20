// ignore: file_names
import 'package:Moodial/services/api.dart';
import 'package:Moodial/models/user.dart';
import 'package:Moodial/screens/charts_screen.dart';
import 'package:Moodial/screens/chartsback_screen.dart';
import 'package:Moodial/widgets/navbar.dart';
import 'package:async/async.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'ScrollChart.dart';
import 'dart:ui' as ui;

DateTime now = DateTime.now();
DateFormat formatter = DateFormat('yyyy');
DateFormat formatterMonth = DateFormat('MM');
String year1 = formatter.format(now);
String month1 = formatterMonth.format(now);
String Currentmonth ="";
int count=0;
Future<MoodValues> getMoodValues(String username) async {
  DateTime pastMonth = DateTime.now().subtract(Duration(days: Something.counter));
  month1=formatterMonth.format(pastMonth);
  year1 = formatter.format(pastMonth);
  var db = await  mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts.fxnqc.mongodb.net/Test?retryWrites=true&w=majority");
  await db.open();
  var coll = db.collection('user');
  print(month1);
  print(Something.counter);
  int monthcount=int.parse(month1)+Something.counter;
  if(monthcount==13)
  {
    monthcount=01;
    Something.yearcounter++;
  }
  else if(monthcount==0)
  {
    monthcount=12;
    Something.yearcounter--;
  }
  int yearcount= int.parse(year1)+Something.yearcounter;
  year1=yearcount.toString();
  if(month1.length==1)
  {
    month1= '0'+month1;
  }
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
  var check = await coll.findOne(mongo.where.eq("username", username).fields(['happy'+month1+year1]));
  if(check['happy'+month1+year1]==null)
  {
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("games"+month1+year1, "0"));
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("happy"+month1+year1, "0"));
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("sad"+month1+year1, "0"));
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("surprised"+month1+year1, "0"));
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("angry"+month1+year1, "0"));
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("bad"+month1+year1, "0"));
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("fearful"+month1+year1, "0"));
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("disgusted"+month1+year1, "0"));
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("shopping"+month1+year1, "0"));
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("work"+month1+year1, "0"));
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("tv"+month1+year1, "0"));
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("sports"+month1+year1, "0"));
    await coll.updateOne(mongo.where.eq("username",username), mongo.modify.set("tv"+month1+year1, "0"));
  }



  print(month1+year1);
  var happy = await coll.findOne(mongo.where.eq("username", username).fields([
    'happy'+month1+year1,
    'sad'+month1+year1,
    'angry'+month1+year1,
    'bad'+month1+year1,
    'fearful'+month1+year1,
    'surprised'+month1+year1,
    'disgusted'+month1+year1,
    'games'+month1+year1,
    'work'+month1+year1,
    'tv'+month1+year1,
    'sports'+month1+year1,
    'shopping'+month1+year1,
  ]));
  await db.close();
  return MoodValues.fromJson(happy);
}

class MoodValues{
  final String HappyVal;
  final String SadVal;
  final String AngryVal;
  final String BadVal;
  final String FearfulVal;
  final String SurpisedVal;
  final String DisgustedVal;
  final String GamesVal;
  final String TvVal;
  final String WorkVal;
  final String SportsVal;
  final String ShoppingdVal;

  MoodValues({
    @required this.HappyVal, this.SadVal, this.AngryVal, this.BadVal,this.FearfulVal,this.SurpisedVal,this.DisgustedVal,this.GamesVal,this.TvVal,this.WorkVal,this.SportsVal,this.ShoppingdVal
  });

  factory MoodValues.fromJson(Map<String, dynamic> json) {
    return MoodValues(
        HappyVal: json['happy'+month1+year1],
        SadVal: json['sad'+month1+year1],
        AngryVal: json['angry'+month1+year1],
        BadVal: json['bad'+month1+year1],
        SurpisedVal: json['surprised'+month1+year1],
        FearfulVal: json['fearful'+month1+year1],
        DisgustedVal: json['disgusted'+month1+year1],
        GamesVal: json['games'+month1+year1],
        TvVal: json['tv'+month1+year1],
        WorkVal: json['work'+month1+year1],
        SportsVal: json['sports'+month1+year1],
        ShoppingdVal: json['shopping'+month1+year1]
    );
  }
}
class ScrollChartsBackScreen extends StatefulWidget {
  final User user;
  final Function navPosCallback;


  ScrollChartsBackScreen({
    this.user,
    this.navPosCallback,
  });

  @override
  _ScrollChartsBackScreenState createState() => _ScrollChartsBackScreenState(
    user: this.user,
    navPosCallback: this.navPosCallback,
  );
}


class _ScrollChartsBackScreenState extends State<ScrollChartsBackScreen> {

  int _currentTab = 4;
  var happy;
  User user;
  String value;
  Function navPosCallback;
  _ScrollChartsBackScreenState({
    this.user,
    this.navPosCallback,
  });

  Map<String, double> dataMap = {
    "happy": 0,
    "sad": 0,
    "surprised": 0,
    "disgusted": 0,
    "angry": 0,
    "fearful": 0,
    "bad": 0,
  };


  List<Color> colorList = [
    Colors.yellow,
    Colors.blue,
    Colors.lightGreen,
    Colors.deepPurple,
    Colors.red,
    Colors.green,
    Colors.lightBlue,
  ];
  Map<String, double> dataMap2 = {
    "Games": 0,
    "TV": 0,
    "Exercise": 0,
    "Shopping": 0,
    "Work": 0,
  };

  List<Color> colorList2 = [
    Colors.blue,
    Colors.pink,
    Colors.deepPurple,
    Colors.yellow,
    Colors.brown
  ];
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy');
  static final DateFormat formatterMonth = DateFormat('MM');
  String yearHolder = formatter.format(now);
  String dropDownYear = formatter.format(now);
  String textHolder = formatterMonth.format(now);
  String dropdownValue = formatterMonth.format(now);

  Widget Chart() {
    return FutureBuilder<MoodValues>(
        future: happy,
        builder: (context, snapshot) {
          Map<String, double> dataMap3 = {
            "Happy": double.parse(snapshot.data.HappyVal),
            "Sad": double.parse(snapshot.data.SadVal),
            "Surprised": double.parse(snapshot.data.SurpisedVal),
            "Disgusted": double.parse(snapshot.data.DisgustedVal),
            "Angry": double.parse(snapshot.data.AngryVal),
            "fearful": double.parse(snapshot.data.FearfulVal),
            "Bad": double.parse(snapshot.data.BadVal),
          };
          if (snapshot.hasData)
            return
              Positioned(top: 100, left: 60,
                  child: PieChart(
                    dataMap: dataMap3,
                    colorList: colorList,
                    chartRadius: MediaQuery
                        .of(context)
                        .size
                        .width / 1.3,
                    legendOptions: LegendOptions(
                      legendPosition: LegendPosition.bottom,
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesInPercentage: true,
                    ),
                  )
              );
          else
            return PieChart(
              dataMap: dataMap,
              colorList: colorList,
              chartRadius: MediaQuery
                  .of(context)
                  .size
                  .width / 1.3,
              legendOptions: LegendOptions(
                legendPosition: LegendPosition.bottom,
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValuesInPercentage: true,
              ),
            );
        });
  }

  Widget Chart2() {
    return FutureBuilder<MoodValues>(
        future: happy,
        builder: (context, snapshot) {
          Map<String, double> dataMap4 = {
            "Games": double.parse(snapshot.data.GamesVal),
            "Sports": double.parse(snapshot.data.SportsVal),
            "Work": double.parse(snapshot.data.WorkVal),
            "Shopping": double.parse(snapshot.data.ShoppingdVal),
            "TV": double.parse(snapshot.data.TvVal)
          };
          if (snapshot.hasData)
            return
              Positioned(top: 400, left: 60,
                  child: PieChart(
                    dataMap: dataMap4,
                    colorList: colorList,
                    chartRadius: MediaQuery
                        .of(context)
                        .size
                        .width / 1.3,
                    legendOptions: LegendOptions(
                      legendPosition: LegendPosition.bottom,
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesInPercentage: true,
                    ),
                  )
              );
          else
            return Positioned(top: 400, left: 60,
                child: PieChart(
                  dataMap: dataMap,
                  colorList: colorList,
                  chartRadius: MediaQuery
                      .of(context)
                      .size
                      .width / 1.3,
                  legendOptions: LegendOptions(
                    legendPosition: LegendPosition.bottom,
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValuesInPercentage: true,
                  ),
                ));
        });
  }
  void initState() {
    //RenderErrorBox.backgroundColor = Colors.white;
    //RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
    super.initState();
    if(value==null)
    {
      value="test";
    }
    print(Something.username);
    happy=getMoodValues(Something.username);

  }
  @override
  Widget build(BuildContext context) {
    if(month1=='11')
    {
      Currentmonth ='November';
    }
    else if(month1=='12')
    {
      Currentmonth ='December';
    }
    else if(month1=='01')
    {
      Currentmonth ='January';
    }
    else if(month1=='02')
    {
      Currentmonth ='February';
    }else if(month1=='03')
    {
      Currentmonth ='March';
    }else if(month1=='04')
    {
      Currentmonth ='April';
    }
    else if(month1=='05')
    {
      Currentmonth ='May';
    }
    else if(month1=='06')
    {
      Currentmonth ='June';
    }
    else if(month1=='07')
    {
      Currentmonth ='July';
    }
    else if(month1=='08')
    {
      Currentmonth ='August';
    }else if(month1=='09')
    {
      Currentmonth ='September';
    }
    else if(month1=='10')
    {
      Currentmonth='October';
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
          child: Container(

              child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(alignment: Alignment.topLeft,
                          child:Padding(
                            padding: EdgeInsets.all(15),
                          child: Text(' '+Currentmonth+" " '$yearHolder',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                         ),
                        ),
                        Container(alignment: Alignment.topRight,
                          child:Padding(
                              padding: EdgeInsets.all(15),
                            child: ElevatedButton(
                                child: const Text('Chart'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(28, 168, 85, 1),
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                ),
                                onPressed: () {
                                  Navigator.popUntil(context, (route) {

                                    return count++ == Something.pop;
                                  });
                                  count=0;
                                  Something.pop=1;
                                }
                            )
                          ),
                        ),

                      ],

                    ),



                      Text("Mood", textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),


                    Chart()
                    ,
                       Text("Activities", textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),

                    Chart2(),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      buttonPadding:EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 60
                      ),
                      children:[


                        Container(
                            child: ElevatedButton(
                                child: const Text('<'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                ),
                                onPressed: () {
                                  backs.works = "true";
                                  backs.pop = backs.pop+1;
                                  Something.counter = Something.counter+30;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ScrollChartsBackScreen(user:this.user,navPosCallback: this.navPosCallback,)),
                                  );
                                }
                            )
                        ),
                        SizedBox(width:160,),
                        Container(
                            child: ElevatedButton(
                                child: const Text('>'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                ),
                                onPressed: () {
                                  backs.works = "true";
                                  backs.pop= backs.pop+1;
                                  Something.counter = Something.counter-30;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ScrollChartsBackScreen(user:this.user,navPosCallback: this.navPosCallback,)),
                                  );
                                }
                            )
                        ),
                      ],
                    ),
                  ]
              )

          )
      ),
      bottomNavigationBar: NavBar(
        currentTab: _currentTab,
        callback: navPosCallback,
      ),
    );

  }
}
class Something {
  static int counter = 0;
  static int yearcounter = 0;
  static String username ='';
  static String month;
  static int pop =1;
}