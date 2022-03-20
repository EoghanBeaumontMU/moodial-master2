import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:Moodial/screens/chartsback_screen.dart';
class NavBar extends StatefulWidget {
  final int currentTab;
  final Function callback;

  NavBar({
    this.currentTab,
    this.callback,
  });

  @override
  _NavBarState createState() => _NavBarState(
        currentTab: this.currentTab,
        callback: this.callback,
      );
}

class _NavBarState extends State<NavBar> {
  int currentTab;
  Function callback;

  _NavBarState({
    this.currentTab,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTab,
      onTap: (int value) {
        setState(() {
          currentTab = value;
        });
        this.callback (value);
        if(backs.works=="true")
          {
            backs.works="false";
              Navigator.popUntil(context, (route) {

                return count++ == backs.pop;
              });
              count=0;
              backs.pop=1;
          }

      },
      items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(
            FeatherIcons.home,
            size: 33,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Stats',
          icon: Icon(
            FeatherIcons.barChart2,
            size: 33,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Calendar',
          icon: Icon(
            FeatherIcons.calendar,
            size: 33,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Settings',
          icon: Icon(
            FeatherIcons.settings,
            size: 33,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Charts',
          icon: Icon(
            FeatherIcons.pieChart,
            size: 33,
          ),
        ),



      ],

    );
    
  }
}
