import 'package:Moodial/services/mood_props.dart';
import 'package:flutter/material.dart';

class AddEntryDial extends StatefulWidget {
  final double sliderValue;
  final Function callback;

  AddEntryDial({this.sliderValue, this.callback});

  @override
  _AddEntryDialState createState() => _AddEntryDialState(
        sliderValue: this.sliderValue,
        callback: this.callback,
      );
}

class _AddEntryDialState extends State<AddEntryDial> {
  double sliderValue;
  Function callback;

  _AddEntryDialState({this.sliderValue, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Theme.of(context).primaryColor,
              inactiveTrackColor: Colors.grey[400],
              thumbColor: Theme.of(context).primaryColor,
              overlayColor: Theme.of(context).primaryColor.withAlpha(32),
              inactiveTickMarkColor: Theme.of(context).primaryColor,
            ),
            child: Slider(
                value: sliderValue,
                min: 1,
                max: 7,
                divisions: 6,
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                  });

                  this.callback(value.round());
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  MoodProps.moodValueToString(sliderValue.toInt()),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MoodProps.moodColor(sliderValue.toInt())
                            .withAlpha(100),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: MoodProps.moodEmoji(sliderValue),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
