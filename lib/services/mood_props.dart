import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoodProps {
  static String moodValueToString(int value) {
    switch (value) {
      case 1:
        return 'Happy';
        break;
      case 2:
        return 'Sad';
        break;
      case 3:
        return 'Surprised';
        break;
      case 4:
        return 'Disgusted';
        break;
      case 5:
        return 'Angry';
      case 6:
        return 'Fearful';
      case 7:
        return 'Bad';
    }

    return 'Error';
  }

  static Color moodColor(int value) {
    switch (value) {
      case 1:
        return Color(0xFFFBDE60);
        break;
      case 2:
        return Color(0xFF5C8FC1);
        break;
      case 3:
        return Color(0xFF3FA5C0);
        break;
      case 4:
        return Color(0xFF9F78BA);
        break;
      case 5:
        return Color(0xFFE84A6A);
        break;
      case 6:
        return Color(0xFF46C365);
        break;
      case 7:
        return Color(0xFF96C895);
    }

    return null;
  }

  static Widget moodEmoji(value) {
    String emojiPath = '';
    switch (value) {
      case 1:
        emojiPath = 'assets/images/happy-emoji.svg';
        break;
      case 2:
        emojiPath = 'assets/images/sad-emoji.svg';
        break;
      case 3:
        emojiPath = 'assets/images/surprised-emoji.svg';
        break;
      case 4:
        emojiPath = 'assets/images/disgusted-emoji.svg';
        break;
      case 5:
        emojiPath = 'assets/images/angry-emoji.svg';
        break;
      case 6:
        emojiPath = 'assets/images/fearful-emoji.svg';
        break;
      case 7:
        emojiPath = 'assets/images/bad-emoji.svg';
    }

    return SvgPicture.asset(
      emojiPath,
      semanticsLabel: 'Mood Emoji from dial value',
      placeholderBuilder: (BuildContext context) =>
          Container(child: const CircularProgressIndicator()),
    );
  }
}
