import 'package:Moodial/screens/home_screen.dart';
import 'package:Moodial/screens/stats_screen.dart';
import 'package:flutter/cupertino.dart';

class PageViewDemo extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        HomeScreen(),
        StatsScreen(),
      ],
    );
  }
}