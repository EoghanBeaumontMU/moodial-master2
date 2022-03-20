import 'package:flutter/material.dart';

class SettingsButton extends StatefulWidget {
  final Color color;
  final Function callback;
  final Icon icon;
  final String label;
  final String subtext;

  SettingsButton({
    this.color,
    this.callback,
    this.icon,
    this.label,
    this.subtext,
  });

  @override
  _SettingsButtonState createState() => _SettingsButtonState(
        color: this.color,
        callback: this.callback,
        icon: this.icon,
        label: this.label,
        subtext: this.subtext,
      );
}

class _SettingsButtonState extends State<SettingsButton> {
  Color color;
  Function callback;
  Icon icon;
  String label;
  String subtext;

  _SettingsButtonState({
    this.color,
    this.callback,
    this.icon,
    this.label,
    this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: this.callback,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.0),
          ),
          height: 100.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Container(
                  child: icon,
                  width: 70,
                ),
                Expanded(
                  child: Container(
                    width: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(subtext),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
