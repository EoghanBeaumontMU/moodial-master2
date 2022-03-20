import 'package:Moodial/screens/calendar_screen.dart';
import 'package:Moodial/screens/chartsback_screen.dart';
import 'package:Moodial/screens/home_screen.dart';
import 'package:Moodial/screens/landing_screen.dart';
import 'package:Moodial/screens/settings_screen.dart';
import 'package:Moodial/screens/stats_screen.dart';
import 'package:Moodial/screens/charts_screen.dart';
import 'package:Moodial/widgets/splash_screen/intro_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

import 'models/user.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    var initializationSettingsAndroid = AndroidInitializationSettings('moodial');
      var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
        (int id, String title, String body, String payload) async {});
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification:(String payload) async{
        if(payload !=null){
          debugPrint('notification payload:' + payload);
        }
        });

  runApp(Moodial());
}

class Moodial extends StatefulWidget {
  @override
  _MoodialState createState() => _MoodialState();
}

class _MoodialState extends State<Moodial> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1AA855),
        scaffoldBackgroundColor: Color(0xFFFEFEFE),
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme.apply(fontSizeFactor: 1.15),
        ),
      ),
      home: new Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new MainApp()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  int cardNum = 1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: this.cardNum != 4
          ? IntroCard(this.cardNum, cardNumUpdate, new UniqueKey())
          : Splash(),
    );
  }

  cardNumUpdate(nextCard) {
    this.setState(() {
      cardNum = nextCard;
    });
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isLoggedIn = false;
   User _user;
  int _navPos = 0;

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn
        ? buildScreenOnNav(_navPos)
        : LandingScreen(
            callback: this.landingCallback,
            isLoggedIn: this._isLoggedIn,
            user: this._user,
          );
  }

  landingCallback(isLoggedIn, user) {
    setState(() {
      _isLoggedIn = isLoggedIn;
      _user = user;
    });
  }

  navPosCallback(navPos) {
    setState(() {
      _navPos = navPos;
    });
  }

  logOutCallback() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  avatarChangeCallback(avatarLink) {
    setState(() {
      _user.avatarLink = avatarLink;
    });
  }

  buildScreenOnNav(_navPos) {
    switch (_navPos) {
      case 0:
        return HomeScreen(
          user: this._user,
          navPosCallback: this.navPosCallback,
        );
      case 1:
        return StatsScreen(
          user: this._user,
          navPosCallback: this.navPosCallback,
        );
      case 2:
        return CalendarScreen(
          user: this._user,
          navPosCallback: this.navPosCallback,
        );
      case 3:
        return SettingsScreen(
          user: this._user,
          navPosCallback: this.navPosCallback,
          logOutCallback: this.logOutCallback,
          avatarChangeCallback: this.avatarChangeCallback,
        );
      case 4:
        return ChartScreen(
          user: this._user,
          navPosCallback: this.navPosCallback,
        );
      case 5:
        return ChartsBackScreen(
          user: this._user,
          navPosCallback: this.navPosCallback,
        );

      default:
        return HomeScreen(
          user: this._user,
          navPosCallback: this.navPosCallback,
        );
    }
  }
}
