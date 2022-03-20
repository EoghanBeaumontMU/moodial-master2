import 'package:Moodial/models/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'dart:io';
import 'package:Moodial/screens/scrollchartsback_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
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
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
Future<Checkboxs> getCheckbox(String username,int entry) async {

  var db = await  mongo.Db.create("mongodb+srv://eoghan:eoghan@moodialcharts.fxnqc.mongodb.net/Test?retryWrites=true&w=majority");
  await db.open();
  var coll = db.collection('user');

  var happy = await coll.findOne(mongo.where.eq("username", username).fields([
    '1check'+entry.toString(),
    '2check'+entry.toString(),
    '3check'+entry.toString(),
    '4check'+entry.toString(),
    '5check'+entry.toString(),
  ]));
  coll.updateOne(mongo.where.eq('username', username), mongo.modify.set('1check'+entry.toString(), Checks2.check1));
  coll.updateOne(mongo.where.eq('username', username), mongo.modify.set('2check'+entry.toString(), Checks2.check2));
  coll.updateOne(mongo.where.eq('username', username), mongo.modify.set('3check'+entry.toString(), Checks2.check3));
  coll.updateOne(mongo.where.eq('username', username), mongo.modify.set('4check'+entry.toString(), Checks2.check4));
  coll.updateOne(mongo.where.eq('username', username), mongo.modify.set('5check'+entry.toString(), Checks2.check5));
  var checks = await coll.findOne(mongo.where.eq("username", username).fields(['1check'+entry.toString()]));
  String check1 ='1check'+entry.toString();
  print(username);
  print(checks['1check'+entry.toString()]);
  Checks2.check1=happy[check1];
  if(Checks2.check1==null)
  {
    Checks2.check1=false;
  }
  Checks2.check2=happy['2check'+entry.toString()];
  if(Checks2.check2==null)
  {
    Checks2.check2=false;
  }
  Checks2.check3=happy['3check'+entry.toString()];
  if(Checks2.check3==null)
  {
    Checks2.check3=false;
  }
  Checks2.check4=happy['4check'+entry.toString()];
  if(Checks2.check4==null)
  {
    Checks2.check4=false;
  }
  Checks2.check5=happy['5check'+entry.toString()];
  if(Checks2.check5==null)
  {
    Checks2.check5=false;
  }
  await db.close();
  return Checkboxs.fromJson(happy,entry);
}
class Checkboxs{
  final bool oneCheckval;
  final bool twoCheckval;
  final bool threeCheckval;
  final bool fourCheckval;
  final bool fiveCheckval;

  Checkboxs({
    @required this.oneCheckval, this.twoCheckval, this.threeCheckval, this.fourCheckval,this.fiveCheckval
  });

  factory Checkboxs.fromJson(Map<String, dynamic> json,int val) {
    return Checkboxs(
        oneCheckval: json['1check'+val.toString()],
        twoCheckval: json['1check'+val.toString()],
        threeCheckval: json['1check'+val.toString()],
        fourCheckval: json['1check'+val.toString()],
        fiveCheckval: json['1check'+val.toString()],
    );
  }
}

class UpdateEntryForm extends StatefulWidget {
  final Function callback;
  final Entry entry;
  final User user;

  UpdateEntryForm(this.callback, this.entry,this.user);

  @override
  _UpdateEntryFormState createState() =>
      _UpdateEntryFormState(this.callback, this.entry,this.user);
}

class _UpdateEntryFormState extends State<UpdateEntryForm> {
  Function callback;
  Entry entry;
  User user;
  var happy;
  bool isChecked5 =Checks2.check5;
  bool isChecked4 =Checks2.check4;
  bool isChecked3 =Checks2.check3;
  bool isChecked2 =Checks2.check2;
  bool isChecked1 =Checks2.check1;

  _UpdateEntryFormState(this.callback, this.entry,this.user);
  final _formKey = GlobalKey<FormState>();

  final sleepController = TextEditingController();
  final medNameController = TextEditingController();
  final medDoseController = TextEditingController();
  final dietFoodController = TextEditingController();
  final dietAmountController = TextEditingController();
  final exerciseController = TextEditingController();
  final notesController = TextEditingController();

  final List<int> iritabilityOptions = new List<int>.generate(10, (i) => i + 1);
  int _iritabilityDropdownValue = 1;
  bool _overwritten = false;

  Map<String, dynamic> formData = {
    'valid': false,
    'sleep': '',
    'iritability': 1,
    'medName': '',
    'medDose': '',
    'dietFood': '',
    'dietAmount': '',
    'exercise': '',
    'notes': '',
  };

  void overwriteTextControllers() {
    if (!_overwritten) {
      sleepController.text = entry.sleep.toString();
      medNameController.text = entry.medication.name;
      medDoseController.text = entry.medication.dose;
      dietFoodController.text = entry.diet.food;
      dietAmountController.text = entry.diet.amount;
      exerciseController.text = entry.exercise;
      notesController.text = entry.notes;
      _overwritten = !_overwritten;

      setState(() {
        _iritabilityDropdownValue = entry.iritability.toInt();
        formData['sleep'] = entry.sleep.toString();
        formData['medName'] = entry.medication.name;
        formData['medDose'] = entry.medication.dose;
        formData['dietFood'] = entry.diet.food;
        formData['dietAmount'] = entry.diet.amount;
        formData['exercise'] = entry.exercise;
        formData['notes'] = entry.notes;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    sleepController.dispose();
    medNameController.dispose();
    medDoseController.dispose();
    dietFoodController.dispose();
    dietAmountController.dispose();
    exerciseController.dispose();
    notesController.dispose();
    super.dispose();
  }
  void initState() {
    RenderErrorBox.backgroundColor = Colors.white;
    RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => mongo.Convert());
  }
  @override
  Widget build(BuildContext context) {
    overwriteTextControllers();
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: sleepController,
                    validator: (value) {
                      if (value == null) {
                        return 'Required field';
                      } else if (double.tryParse(value) == null) {
                        return 'Must be a numerical value';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Sleep',
                        hintText: 'Hours',
                        labelStyle: TextStyle(fontSize: 14.0)),
                    onChanged: (value) {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          formData['valid'] = true;
                          formData['sleep'] = sleepController.text;
                        });
                        this.callback(formData);
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _iritabilityDropdownValue,
                    onChanged: (value) {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _iritabilityDropdownValue = value;
                          formData['valid'] = true;
                          formData['iritability'] = _iritabilityDropdownValue;
                        });
                        this.callback(formData);
                      }
                    },
                    validator: (int value) {
                      if (value == null) {
                        return 'Required field';
                      }
                      return null;
                    },
                    items: iritabilityOptions
                        .map((int item) => DropdownMenuItem<int>(
                            child: Text(item.toString()), value: item))
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Iritability',
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Medication',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: medNameController,
                    validator: (value) {
                      if (value == null) {
                        return 'Required field';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      if (_formKey.currentState.validate()) {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            formData['valid'] = true;
                            formData['medName'] = medNameController.text;
                          });
                          this.callback(formData);
                        }
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: TextFormField(
                    controller: medDoseController,
                    validator: (value) {
                      if (value == null) {
                        return 'Required field';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          formData['valid'] = true;
                          formData['medDose'] = medDoseController.text;
                        });
                        this.callback(formData);
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Dose',
                        labelStyle: TextStyle(fontSize: 14.0)),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Diet',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: dietFoodController,
                    validator: (value) {
                      if (value == null) {
                        return 'Required field';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          formData['valid'] = true;
                          formData['dietFood'] = dietFoodController.text;
                        });
                        this.callback(formData);
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Food',
                        labelStyle: TextStyle(fontSize: 14.0)),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: TextFormField(
                    controller: dietAmountController,
                    validator: (value) {
                      if (value == null) {
                        return 'Required field';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          formData['valid'] = true;
                          formData['dietAmount'] = dietAmountController.text;
                        });
                        this.callback(formData);
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(fontSize: 14.0)),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            TextFormField(
              controller: exerciseController,
              onChanged: (value) {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    formData['valid'] = true;
                    formData['exercise'] = exerciseController.text;
                  });
                  this.callback(formData);
                }
              },
              decoration: InputDecoration(
                  labelText: 'Exercise', labelStyle: TextStyle(fontSize: 14.0)),
            ),
            TextFormField(
              controller: notesController,
              maxLines: 4,
              onChanged: (value) {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    formData['valid'] = true;
                    formData['notes'] = notesController.text;
                  });
                  this.callback(formData);
                }
              },
              decoration: InputDecoration(
                  labelText: 'Notes', labelStyle: TextStyle(fontSize: 14.0)),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Activivities',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.gamepad ,
                  color: Colors.black,
                  size: 40.0,
                ),
                SizedBox(width: 12.5),
                Icon(
                  Icons.work,
                  color: Colors.black,
                  size: 40.0,
                ),
                SizedBox(width: 12.5),
                Icon(
                  Icons.sports_soccer,
                  color: Colors.black,

                  size: 40.0,
                ),
                SizedBox(width: 12.5),
                Icon(
                  Icons.tv_sharp,
                  color: Colors.black,
                  size: 40.00,
                ),
                SizedBox(width: 12.5),
                Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                  size: 40.0,
                ),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 2,
                  child:Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked1,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked1 = value;
                        Checks2.check1=value;
                      });

                    },
                  ),
                ),
                SizedBox(width: 5),
                Transform.scale(
                  scale: 2,
                  child:Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked2,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked2 = value;
                        Checks2.check2=value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 5),
                Transform.scale(
                  scale: 2,
                  child:Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked3,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked3 = value;
                        Checks2.check3=value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 5),
                Transform.scale(
                  scale: 2,
                  child:Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked4,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked4 = value;
                        Checks2.check4=value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 5),
                Transform.scale(
                  scale: 2,
                  child:Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked5,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked5 = value;
                        Checks2.check5=value;
                      });
                    },
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
class Checks2 {
  static bool check1=false;
  static bool check2=false;
  static bool check3=false;
  static bool check4=false;
  static bool check5=false;
}