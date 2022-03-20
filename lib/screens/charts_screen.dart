// ignore: file_names
import 'dart:io';
import 'package:Moodial/api/Nofitican.dart';
import 'package:Moodial/screens/chartsback_screen.dart';
import 'package:Moodial/services/api.dart';
import 'package:Moodial/models/user.dart';
import 'package:Moodial/widgets/navbar.dart';
import 'package:async/async.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import '../main.dart';
import 'ScrollChart.dart';
import 'dart:ui' as ui;
import 'package:dcdg/dcdg.dart';
final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy');
final DateFormat formatterMonth = DateFormat('MM');
String year1 = formatter.format(now);
String month1 = formatterMonth.format(now);

Future<MoodValues> getMoodValues(String username) async {

  var db = await  mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts.fxnqc.mongodb.net/Test?retryWrites=true&w=majority");
  await db.open();
  var coll = db.collection('user');
  print(month1);
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


  print(month1);
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
class ChartScreen extends StatefulWidget {
final User user;
final Function navPosCallback;


ChartScreen({
  this.user,
  this.navPosCallback,
});


@override
_ChartScreenState createState() => _ChartScreenState(
  user: this.user,
  navPosCallback: this.navPosCallback,
);
}

class _ChartScreenState extends State<ChartScreen> {

  int _currentTab = 4;
  User user;
  var happy;
  String value;
  Function navPosCallback;
  _ChartScreenState({
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

  Convert() {
    setState(() {
      if (textHolder == '02') {
        textHolder = 'February';
        dropdownValue = 'February';
      } else if (textHolder == '03') {
        textHolder = 'March';
        dropdownValue = 'March';
      }
      else if (textHolder == '04') {
        textHolder = 'April';
        dropdownValue = 'April';
      }
      else if (textHolder == '05') {
        textHolder = 'May';
        dropdownValue = 'May';
      }
      else if (textHolder == '06') {
        textHolder = 'June';
        dropdownValue = 'June';
      }
      else if (textHolder == '07') {
        textHolder = 'July';
        dropdownValue = 'July';
      }
      else if (textHolder == '08') {
        textHolder = 'August';
        dropdownValue = 'August';
      }
      else if (textHolder == '09') {
        textHolder = 'September';
        dropdownValue = 'September';
      }
      else if (textHolder == '10') {
        textHolder = 'October';
        dropdownValue = 'October';
      }
      else if (textHolder == '11') {
        textHolder = 'November';
        dropdownValue = 'November';
      }
      else if (textHolder == '12') {
        textHolder = 'December';
        dropdownValue = 'December';
      }
      else if (textHolder == '01') {
        textHolder = 'January';
        dropdownValue = 'January';
      }
    });
  }

  changeText() {

    setState(() {
      if (textHolder=='January') {
        textHolder = 'February';
      }  else if(textHolder=='February'){
        textHolder = 'March';
      }
      else if(textHolder=='March'){
        textHolder = 'April';
      }
      else if(textHolder=='April'){
        textHolder = 'May';
      }
      else if(textHolder=='May'){
        textHolder = 'June';
      }
      else if(textHolder=='June'){
        textHolder = 'July';
      }
      else if(textHolder=='July'){
        textHolder = 'August';
      }
      else if(textHolder=='August'){
        textHolder = 'September';
      }
      else if(textHolder=='September'){
        textHolder = 'October';
      }
      else if(textHolder=='October'){
        textHolder = 'November';
      }
      else if(textHolder=='October'){
        textHolder = 'November';
      }
      else if(textHolder=='November'){
        textHolder = 'December';
      }
      else if(textHolder=='December'){
        textHolder = 'January';
        var yeartemp = int.parse(yearHolder);
        yeartemp = yeartemp +1;
        yearHolder = yeartemp.toString();
      }
    });


  }
  changeBackwardText() {

    setState(() {
      if (textHolder=='January') {
        textHolder = 'December';
        var yeartemp = int.parse(yearHolder);
        yeartemp = yeartemp -1;
        yearHolder = yeartemp.toString();
      }  else if(textHolder=='February'){
        textHolder = 'January';
      }
      else if(textHolder=='March'){
        textHolder = 'February';
      }
      else if(textHolder=='April'){
        textHolder = 'March';
      }
      else if(textHolder=='May'){
        textHolder = 'April';
      }
      else if(textHolder=='June'){
        textHolder = 'May';
      }
      else if(textHolder=='July'){
        textHolder = 'June';
      }
      else if(textHolder=='August'){
        textHolder = 'July';
      }
      else if(textHolder=='September'){
        textHolder = 'August';
      }
      else if(textHolder=='October'){
        textHolder = 'September';
      }
      else if(textHolder=='November'){
        textHolder = 'October';
      }
      else if(textHolder=='December'){
        textHolder = 'November';
      }
    });


  }
  Widget Chart(){

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
              Positioned(top: 100, left: 50,
              child:PieChart(
            dataMap: dataMap3,
            colorList: colorList,
            chartRadius: MediaQuery.of(context).size.width / 2,
            legendOptions: LegendOptions(
              legendPosition: LegendPosition.right,
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
            chartRadius: MediaQuery.of(context).size.width / 2,
            legendOptions: LegendOptions(
              legendPosition: LegendPosition.right,
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
          );
        });
  }
  Widget Chart2(){

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
              Positioned(top: 370, left: 50,
                  child:PieChart(
                    dataMap: dataMap4,
                    colorList: colorList,
                    chartRadius: MediaQuery.of(context).size.width / 2,
                    legendOptions: LegendOptions(
                      legendPosition: LegendPosition.right,
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesInPercentage: true,
                    ),
                  )
              );
          else
            return Positioned(top: 370, left: 60,
          child:PieChart(
              dataMap: dataMap,
              colorList: colorList,
              chartRadius: MediaQuery.of(context).size.width / 2,
              legendOptions: LegendOptions(
                legendPosition: LegendPosition.right,
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValuesInPercentage: true,
              ),
            ));
        });
  }

  void initState() {
    RenderErrorBox.backgroundColor = Colors.white;
    RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => Convert());
    if(value==null)
    {
      value="test";
    }
    backs.works='false';
    happy=getMoodValues(user.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
      ),
        body: Container(
            child: Container(

                child: Stack(
                    children: <Widget>[

                      Container(alignment: Alignment.topLeft,
                    child:Padding(
                      padding: EdgeInsets.all(15),
                        child: Text(' $textHolder'+" " '$yearHolder',
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
                          child: const Text('ScrollChart'),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(28, 168, 85, 1),
                                onPrimary: Colors.white,
                                onSurface: Colors.grey,
                              ),
                          onPressed: () {
                            backs.works = "true";
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ScrollChartScreen(user: this.user,navPosCallback: this.navPosCallback,)),
                            );
                          }
                      )
                      ),
                      ),

                      Positioned(top: 60.0,left:145,
                        child:Text("Mood", textAlign: TextAlign.left, style: TextStyle(color: Colors.black,fontSize: 25),
                        ),
                      ),
                      Positioned(top: 320.0,left:125,
                        child:Text("Activities", textAlign: TextAlign.left, style: TextStyle(color: Colors.black,fontSize: 25),
                        ),
                      ),


                        Chart()
                      ,

                        Chart2(),

                      Container(alignment: Alignment.bottomLeft, child:Padding(
                          padding: EdgeInsets.all(15),child: ElevatedButton(
                          child: const Text('<'),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(28, 168, 85, 1),
                            onPrimary: Colors.white,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            backs.counter=30;
                            backs.username=user.username;
                            backs.works='true';
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChartsBackScreen(user: this.user,navPosCallback: this.navPosCallback)),
                            );
                          }
                      )
                      ),
                      ),
                      Container(alignment: Alignment.bottomRight, child:Padding(
                          padding: EdgeInsets.all(15),child: ElevatedButton(
                          child: const Text('>'),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(28, 168, 85, 1),
                            onPrimary: Colors.white,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            backs.counter=-30;
                            backs.username=user.username;
                            backs.works='true';
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChartsBackScreen(user: this.user,navPosCallback: this.navPosCallback)),
                            );
                          }
                      )
                      ),
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


