import 'package:Moodial/models/entry.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SleepIritabilityChart extends StatefulWidget {
  final List<Entry> entryList;

  SleepIritabilityChart(this.entryList);

  @override
  _SleepIritabilityChartState createState() =>
      _SleepIritabilityChartState(entryList);
}

class _SleepIritabilityChartState extends State<SleepIritabilityChart> {
  List<Entry> entryList;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  _SleepIritabilityChartState(this.entryList);

  final Color leftBarColor = Color(0xFF1AA855);
  final Color rightBarColor = Color(0xFFE84A6A);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();

    showingBarGroups = [];
    int i = 0;
    entryList.sublist(entryList.length - 7).forEach((entry) {
      showingBarGroups.add(makeGroupData(
          i, entry.sleep.toDouble(), entry.iritability.toDouble()));
      i = i + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
      child: Container(
        child: BarChart(
          BarChartData(
            maxY: 10,
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                  color: Color(0xff7589a2),
                  fontSize: 12,
                ),
                margin: 8,
                getTitles: (value) {
                  return DateFormat('dd-MM')
                      .format(dateFormat.parse(entryList[value.toInt()].date));
                },
              ),
              leftTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: Color(0xff7589a2),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                margin: 12,
                reservedSize: 28,
                getTitles: (value) {
                  if (value == 0) {
                    return '0';
                  } else if (value == 10) {
                    return '10';
                  } else {
                    return '';
                  }
                },
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: const Color(0xff37434d),
                width: 0.5,
              ),
            ),
            barGroups: showingBarGroups,
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }
}
