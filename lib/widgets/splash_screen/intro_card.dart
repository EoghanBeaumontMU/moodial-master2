import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroCard extends StatefulWidget {
  final int cardNum;
  final Function callback;
  final UniqueKey key;

  IntroCard(this.cardNum, this.callback, this.key);

  @override
  _IntroCardState createState() =>
      _IntroCardState(this.cardNum, this.callback, this.key);
}

class _IntroCardState extends State<IntroCard> {
  int cardNum;
  Function callback;
  UniqueKey key;

  _IntroCardState(this.cardNum, this.callback, this.key);

  Map<String, dynamic> cardInfo = {};

  @override
  Widget build(BuildContext context) {
    switch (cardNum) {
      case 1:
        cardInfo = {
          'image': 'assets/images/welcome-screen.gif',
          'header': 'Welcome to Moodial',
          'text1':
              'Moodial is a mood tracker that helps you keep an eye on your mental wellbeing in a fast-paced world. \n',
          'text2':
              'Mood tracking is a technique in positive psychology that includes the tracking, recording, and analysis of one\'s mood.',
          'buttonText': 'Okay',
        };
        break;
      case 2:
        cardInfo = {
          'image': 'assets/images/mood-tracking.gif',
          'header': 'Mood Tracking',
          'text1':
              'Psychotherapists recommened mood tracking to people who want to improve their mental health.\n',
          'text2':
              'It can be used personally or to support a counselling programme with a professional psychotherapist. Moodial simply helps you with this process.',
          'buttonText': 'NICE',
        };
        break;
      case 3:
        cardInfo = {
          'image': 'assets/images/in-your-own-time.gif',
          'header': 'In your own time',
          'text1':
              'Whenever you get the chance to open up Moodial, you can quickly dial in how you felt. You can add in extra details straight away, or at a time that suits you.\n',
          'text2':
              'Moodial also provides some statistics so you can build associations between your routine and mood.',
          'buttonText': 'LET\'S GO',
        };
        break;
      default:
        cardInfo = {
          'image': 'assets/images/welcome-screen.gif',
          'header': 'Error',
          'text1': 'Sorry! An error has happened somewhere along the way...',
          'text2': 'Please restart the app.',
          'buttonText': '',
        };
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            offset: Offset(5, 10),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Scrollbar(
              isAlwaysShown: true,
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      constraints: BoxConstraints(minHeight: 100),
                      child: AnimatedSwitcher(
                        child: Image(
                          image: AssetImage(cardInfo['image']),
                          key: ValueKey<String>(cardInfo['image']),
                        ),
                        duration: Duration(milliseconds: 250),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedSwitcher(
                      child: Text(
                        cardInfo['header'],
                        key: ValueKey<String>(cardInfo['header']),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      duration: Duration(milliseconds: 250),
                    ),
                  ),
                  SizedBox(height: 5),
                  AnimatedSwitcher(
                    child: Text(
                      cardInfo['text1'],
                      key: ValueKey<String>(cardInfo['text1']),
                    ),
                    duration: Duration(milliseconds: 250),
                  ),
                  AnimatedSwitcher(
                    child: Text(
                      cardInfo['text2'],
                      key: ValueKey<String>(cardInfo['text2']),
                    ),
                    duration: Duration(milliseconds: 250),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                          color: this.cardNum == 1
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).primaryColor.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                          color: this.cardNum == 2
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).primaryColor.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                          color: this.cardNum == 3
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).primaryColor.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => this.callback(cardNum + 1),
                    child: AnimatedSwitcher(
                      child: Text(cardInfo['buttonText']),
                      duration: Duration(milliseconds: 250),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
