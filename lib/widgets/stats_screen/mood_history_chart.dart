import 'package:Moodial/models/entry.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MoodHistoryChart extends StatefulWidget {
  final List<Entry> entryList;

  MoodHistoryChart(this.entryList);

  @override
  _MoodHistoryChartState createState() =>
      _MoodHistoryChartState(this.entryList);
}

class _MoodHistoryChartState extends State<MoodHistoryChart> {
  List<Entry> entryList;
  _MoodHistoryChartState(this.entryList);

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0),
      child: Container(
        width: double.infinity,
        child: LineChart(
          data(entryList.sublist(entryList.length - 7)),
        ),
      ),
    );
  }

  LineChartData data(List<Entry> entryList) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.3,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.3,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => GoogleFonts.montserrat(
            color: Color(0xff68737d),
            fontSize: 12,
          ),
          getTitles: (value) {
            return DateFormat('dd-MM')
                .format(dateFormat.parse(entryList[value.toInt()].date));
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => GoogleFonts.montserrat(
            color: Color(0xff68737d),
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '🙂';
              case 2:
                return '🙁';
              case 3:
                return '😮';
              case 4:
                return '🤢';
              case 5:
                return '😡';
              case 6:
                return '😨';
              case 7:
                return '😔';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: const Color(0xff37434d),
          width: 0.5,
        ),
      ),
      minX: 0,
      maxX: 6,
      minY: 1,
      maxY: 7,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, entryList[0].mood.toDouble()),
            FlSpot(1, entryList[1].mood.toDouble()),
            FlSpot(2, entryList[2].mood.toDouble()),
            FlSpot(3, entryList[3].mood.toDouble()),
            FlSpot(4, entryList[4].mood.toDouble()),
            FlSpot(5, entryList[5].mood.toDouble()),
            FlSpot(6, entryList[6].mood.toDouble()),
          ],
          isCurved: true,
          colors: [Theme.of(context).primaryColor],
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
      ],
    );
  }
}
