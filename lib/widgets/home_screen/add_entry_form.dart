import 'package:flutter/material.dart';

class AddEntryForm extends StatefulWidget {
  final Function callback;
  AddEntryForm(this.callback);
  @override
  _AddEntryFormState createState() => _AddEntryFormState(this.callback);
}

class _AddEntryFormState extends State<AddEntryForm> {
  Function callback;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;

  _AddEntryFormState(this.callback);
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
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
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
      padding: const EdgeInsets.fromLTRB(4.0, 10, 20.0, 0),
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
                'Activities',
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
                        Checks.check1= value;
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
                        Checks.check2= value;
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
                        Checks.check3= value;
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
                        Checks.check4= value;
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
                        Checks.check5= value;
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
class Checks {
  static bool check1=false;
  static bool check2=false;
  static bool check3=false;
  static bool check4=false;
  static bool check5=false;
}
