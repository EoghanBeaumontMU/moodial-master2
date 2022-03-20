import 'dart:io';

import 'package:Moodial/services/api.dart';
import 'package:Moodial/models/user.dart';
import 'package:Moodial/services/email_csv.dart';
import 'package:Moodial/widgets/settings_screen/avatar.dart';
import 'package:Moodial/widgets/navbar.dart';
import 'package:Moodial/widgets/settings_screen/settings_button.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import 'ScrollChart.dart';
import 'home_screen.dart';
import 'note2.dart';
import 'notifition_screen.dart';

Future<UserAvatar1> getAvatar1(username) async {
  var db = await  mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts.fxnqc.mongodb.net/Test?retryWrites=true&w=majority");
  await db.open();
  var coll = db.collection('user');
  var avatar = await coll.findOne(mongo.where.eq("username", username).fields(['avatar']));
  print(avatar["avatar"]);
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
class SettingsScreen extends StatefulWidget {
  final User user;
  final Function navPosCallback;
  final Function logOutCallback;
  final Function avatarChangeCallback;
  SettingsScreen({
    this.user,
    this.navPosCallback,
    this.logOutCallback,
    this.avatarChangeCallback,
  });
  @override
  _SettingsScreenState createState() => _SettingsScreenState(

        user: this.user,
        navPosCallback: this.navPosCallback,
        logOutCallback: this.logOutCallback,
        avatarChangeCallback: this.avatarChangeCallback,
      );
}

class _SettingsScreenState extends State<SettingsScreen> {
  String value;
  var avatar;
  void initState() {
    if(value==null)
    {
      value="test";
    }
    avatar=getAvatar1(user.username);

  }
  Widget pic(){
    return FutureBuilder<UserAvatar1>(
        future: avatar,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return CircleAvatar(
              radius:60.0,
                backgroundColor: Colors.greenAccent,
              child: CircleAvatar(
              radius:55.0,
              backgroundColor: Colors.green,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: FileImage(File(snapshot.data.picture))
              )
              )
            );
          else
            return  CircleAvatar(
                radius:60.0,
                backgroundColor: Colors.greenAccent,
                child: CircleAvatar(
                    radius:55.0,
                    backgroundColor: Colors.green,
                    child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage("https://i.imgur.com/BlJEjuV.png")
                    )
                )
            );// or some other placeholder
        });
  }
  int _currentTab = 3;
  User user;
  Function navPosCallback;
  Function logOutCallback;
  Function avatarChangeCallback;

  final avatarLinkController = TextEditingController();
  final exportEmailController = TextEditingController();

  _SettingsScreenState({
    this.user,
    this.navPosCallback,
    this.logOutCallback,
    this.avatarChangeCallback,
  });
  showDeleteModal() {
    showModalBottomSheet(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Color.fromRGBO(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: IconButton(
                    icon: Icon(FeatherIcons.x),
                    color: Colors.white,
                    iconSize: 40.0,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Icon(FeatherIcons.alertOctagon, size: 40.0),
                        Text(
                          'WARNING',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                          child: Text(
                              'Pressing the Delete button will permanently delete your user data from our database.\n\nIf this data is important to you, we strongly recommend backing it up or not deleting your account. You can press the X icon above to leave this screen and preserve your data.'),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: ElevatedButton(
                        child: Text('DELETE'),
                        onPressed: () {
                          ApiService.deleteUser(user.userToken, user.username)
                              .then((response) {
                            if (response == 'User and entries deleted') {
                              this.logOutCallback();
                            }
                            Navigator.pop(context);
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFE84A6A))),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  showAvatarChangeModal() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => addPicture()),
      );

  }


  showExportModal() {
    showModalBottomSheet(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Color.fromRGBO(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: IconButton(
                    icon: Icon(FeatherIcons.x),
                    color: Colors.white,
                    iconSize: 40.0,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: Platform.isAndroid
                      ? [
                          Column(
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Icon(FeatherIcons.send, size: 40),
                              SizedBox(
                                height: 40.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(
                                    'Enter an email address to send your list of entries as a CSV attachment to.'),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 10.0, 15.0, 0),
                                child: Form(
                                  child: TextFormField(
                                    controller: exportEmailController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                    ),
                                    enableSuggestions: false,
                                    autocorrect: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40.0,
                            child: ElevatedButton(
                              child: Text('SEND'),
                              onPressed: () {
                                ApiService.getEntryList(user.userToken)
                                    .then((response) {
                                  EmailCSV.sendEmail(
                                    user.username,
                                    exportEmailController.text,
                                    response,
                                  );
                                  Navigator.pop(context);
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Theme.of(context).primaryColor)),
                            ),
                          )
                        ]
                      : [
                          SizedBox(
                            height: 20.0,
                          ),
                          Icon(FeatherIcons.send, size: 40),
                          SizedBox(
                            height: 40.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                                'Unfortunately, at the moment, this feature is only available for Android devices. We hope to make it available for other platforms soon!'),
                          ),
                        ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    avatarLinkController.dispose();
    exportEmailController.dispose();
    super.dispose();
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
                )
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                        ),
                      ),
                      pic(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Column(
                  children: [
                    SettingsButton(
                      color: Color(0xFF3FA5C0),
                      callback: () => showAvatarChangeModal(),
                      icon: Icon(FeatherIcons.user, size: 40.0),
                      label: 'Avatar',
                      subtext: 'Pick a image from your gallery as your avatar. Restart app to see new avatar ',
                    ),
                    SettingsButton(
                      color: Color(0xFF96C895),
                      callback: () => showExportModal(),
                      icon: Icon(FeatherIcons.send, size: 40.0),
                      label: 'Export',
                      subtext:
                          'Export all of your entries and email them to yourself or a clinician',
                    ),
                    SettingsButton(
                      color: Color(0xFFFBDE60),
                      callback: () {
                        this.logOutCallback();
                        this.navPosCallback(0);
                      },
                      icon: Icon(FeatherIcons.logOut, size: 40.0),
                      label: 'Log out',
                      subtext: 'See you soon!',
                    ),
                    SettingsButton(
                      color: Color(0xFFE84A6A),
                      callback: showDeleteModal,
                      icon: Icon(FeatherIcons.alertOctagon, size: 40.0),
                      label: 'Delete',
                      subtext:
                          'Remove this user and it\'s entries from our database',
                    ),
                  ],
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
}
Future<UserAvatar> getAvatar() async {
  var db = await  mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts.fxnqc.mongodb.net/Test?retryWrites=true&w=majority");
  await db.open();
  var coll = db.collection('user');
  var avatar = await coll.findOne(mongo.where.eq("username", "Eoghan").fields(['avatar']));
  print(avatar["avatar"]);
  await db.close();
  return UserAvatar.fromJson(avatar);
}
class UserAvatar{
  final String picture;

  UserAvatar({
    @required this.picture
  });

  factory UserAvatar.fromJson(Map<String, dynamic> json) {
    return UserAvatar(
     picture: json['avatar']
    );
  }
}
class addPicture extends StatefulWidget {

  const addPicture({Key key}) : super(key: key);

  @override
  State<addPicture> createState() => _addPicture();
}


class _addPicture extends State<addPicture> {
  File image;
  String value;
  var avatar;
  void initState() {
    if(value==null)
      {
        value="test";
      }
    avatar=getAvatar();
    _asyncMethod();

  }
  _asyncMethod() async {
    getImage();
    Navigator.pop(context);
  }
 Future getImage() async {
    try {
      final  image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
        Directory directory = await getApplicationDocumentsDirectory();
        String path = directory.path;
        final File newImage = await image.copy('$path/image1.png');
        final fileName = Path.basename(newImage.path);
        final File localImage = await image.copy('$path/$fileName');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('test_image', localImage.path);
      value = prefs.getString('test_image');
      //var db = await mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts-shard-00-00.fxnqc.mongodb.net:27017,moodialcharts-shard-00-01.fxnqc.mongodb.net:27017, moodialcharts-shard-00-02.fxnqc.mongodb.net:27017/Test?retryWrites=true&w=majority");
      var db = await  mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts.fxnqc.mongodb.net/Test?retryWrites=true&w=majority");
      await db.open();
      var coll = db.collection('user');
      coll.updateOne(mongo.where.eq('username', 'Eoghan'), mongo.modify.set('avatar', value));
      await db.close();
        setState(() => this.image = newImage,
        );

    } on PlatformException catch (e) {
      print('Failed to pick image:$e');
    }
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AddPicture"),
          centerTitle: true,
          backgroundColor: Colors.green[700],
          brightness: Brightness.dark,
        ),

        body: Container(

          child:
            Container(
                child: Stack(
                    children: [
                      Align(alignment: Alignment.center,
                        child: InkWell(
                          onTap: getImage,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 90,
                            child: CircleAvatar(
                              radius: 80.0,
                              child: ClipOval(
                                child: (image != null)
                                    ? Image.file(image)
                                    : Image.asset('assets/images/avatar.png'),
                              ),
                            ),
                          ),
                        ),

                      ),


                    ]
                )
            )
        )
    );
  }
}

