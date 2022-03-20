import 'package:Moodial/models/entry.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FoodChart extends StatefulWidget {
  final List<Entry> entryList;

  FoodChart(this.entryList);

  @override
  _FoodChartState createState() => _FoodChartState(entryList);
}

class _FoodChartState extends State<FoodChart> {
  List<Entry> entryList;

  _FoodChartState(this.entryList);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 250,
              child: PieChart(
                PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections(entryList)),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...getIndicators(entryList),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(entryList) {
    Map<String, int> uniqueFoods = {};

    entryList.sublist(entryList.length - 7).forEach((entry) {
      if (uniqueFoods.containsKey(entry.diet.food)) {
        uniqueFoods.update(entry.diet.food, (value) => value + 1);
      } else {
        uniqueFoods[entry.diet.food] = 1;
      }
    });

    List<int> values = uniqueFoods.values.toList();

    return List.generate(uniqueFoods.length, (i) {
      final double fontSize = 16;
      final double radius = 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: ((values[0].toDouble() / 7) * 100),
            title: ((values[0].toDouble() / 7) * 100).toInt().toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: ((values[1].toDouble() / 7) * 100),
            title: ((values[1].toDouble() / 7) * 100).toInt().toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: ((values[2].toDouble() / 7) * 100),
            title: ((values[2].toDouble() / 7) * 100).toInt().toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: ((values[3].toDouble() / 7) * 100),
            title: ((values[3].toDouble() / 7) * 100).toInt().toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 4:
          return PieChartSectionData(
            color: const Color(0xFFE84A6A),
            value: ((values[4].toDouble() / 7) * 100),
            title: ((values[4].toDouble() / 7) * 100).toInt().toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 5:
          return PieChartSectionData(
            color: const Color(0xFFFBDE60),
            value: ((values[5].toDouble() / 7) * 100),
            title: ((values[5].toDouble() / 7) * 100).toInt().toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 6:
          return PieChartSectionData(
            color: const Color(0xFF3FA5C0),
            value: ((values[6].toDouble() / 7) * 100),
            title: ((values[6].toDouble() / 7) * 100).toInt().toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  List<Widget> getIndicators(entryList) {
    List<String> uniqueFoods = [];

    entryList.sublist(entryList.length - 7).forEach((entry) {
      if (!uniqueFoods.contains(entry.diet.food) && entry.diet.food != '')
        uniqueFoods.add(entry.diet.food);
      if (!uniqueFoods.contains('Not listed') && entry.diet.food == '')
        uniqueFoods.add('Not listed');
    });

    return List.generate(uniqueFoods.length, (i) {
      switch (i) {
        case 0:
          return Indicator(
            color: Color(0xff0293ee),
            text: uniqueFoods[0],
          );
        case 1:
          return Indicator(
            color: Color(0xfff8b250),
            text: uniqueFoods[1],
          );
        case 2:
          return Indicator(
            color: Color(0xff845bef),
            text: uniqueFoods[2],
          );
        case 3:
          return Indicator(
            color: Color(0xff13d38e),
            text: uniqueFoods[3],
          );
        case 4:
          return Indicator(
            color: Color(0xFFE84A6A),
            text: uniqueFoods[4],
          );
        case 5:
          return Indicator(
            color: Color(0xFFFBDE60),
            text: uniqueFoods[5],
          );
        case 6:
          return Indicator(
            color: Color(0xFF3FA5C0),
            text: uniqueFoods[6],
          );
        default:
          return null;
      }
    });
  }
}

class Indicator extends StatelessWidget {
  Indicator({Key key, this.text, this.color}) : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 50),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xff7589a2),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
