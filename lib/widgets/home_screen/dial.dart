import 'package:flutter/material.dart';
import'package:google_fonts/google_fonts.dart';

class Dial extends StatefulWidget {
  final Function callback;

  Dial({this.callback});

  @override
  _DialState createState() => _DialState(
        callback: this.callback,
      );
}

class _DialState extends State<Dial> {
  double _currentSliderValue = 1;
  Function callback;

  _DialState({this.callback});

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
                value: _currentSliderValue,
                min: 1,
                max: 7,
                divisions: 6,
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });

                  this.callback(value.round());
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderIndicator('Happy', 1),
                  sliderIndicator('Sad', 2),
                  sliderIndicator('Surprised', 3),
                  sliderIndicator('Disgusted', 4),
                  sliderIndicator('Angry', 5),
                  sliderIndicator('Fearful', 6),
                  sliderIndicator('Bad', 7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sliderIndicator(text, value) {
    return AnimatedDefaultTextStyle(
      child: Text(text),
      style: _currentSliderValue == value
          ? GoogleFonts.montserrat(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            )
          : GoogleFonts.montserrat(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
      duration: Duration(milliseconds: 250),
    );
  }
}
