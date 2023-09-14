import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:polybudget/features/week_overview/domain/bar_data_class.dart';

class MyBarGraph extends StatelessWidget {
  final List<double> weeklySummary; // all transaction from mon to sun
  const MyBarGraph({super.key, required this.weeklySummary});


  @override
  Widget build(BuildContext context) {
    final double weeklyMax = weeklySummary.reduce((value, element) => value > element ? value : element);
    BarData myBarData = BarData(
        monAmount: weeklySummary[0],
        tueAmount: weeklySummary[1],
        wedAmount: weeklySummary[2],
        thuAmount: weeklySummary[3],
        friAmount: weeklySummary[4],
        satAmount: weeklySummary[5],
        sunAmount: weeklySummary[6]
    );
    myBarData.initBarData();

    return BarChart(
      BarChartData(
        maxY: weeklyMax,
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: true),
        titlesData: const FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomTitles,)),
          // leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getLeftTiles, reservedSize: 50.0)),
        ),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(
                x: data.x,
                barRods: [BarChartRodData(
                  toY: data.y,
                  color: Colors.pink,
                  width: 15,
                  borderRadius: BorderRadius.circular(4.0),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 100,
                    color: Colors.grey[100],
                  ),
                )],
        ))
          .toList(),
      )

    );
  }
}

Widget getBottomTitles ( double value, TitleMeta meta) {
  const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('M', style: style,);
      break;
    case 1:
      text = const Text('T', style: style,);
      break;
    case 2:
      text = const Text('W', style: style,);
      break;
    case 3:
      text = const Text('T', style: style,);
      break;
    case 4:
      text = const Text('F', style: style,);
      break;
    case 5:
      text = const Text('S', style: style,);
      break;
    case 6:
      text = const Text('S', style: style,);
      break;
    default:
      text = const Text('', style: style,);
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

Widget getLeftTiles(double value, TitleMeta meta){
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
    );

    final String labelText = value.toStringAsFixed(2);
    final List<String> lines = labelText.split(' ');

    return Expanded(
      child: Row(
        children: lines
            .map((line) => Padding(
          padding: const EdgeInsets.only(right: 0.0), // Add spacing between labels
          child: Text(line, style: style),
        ))
            .toList(),
      ),
    );
}