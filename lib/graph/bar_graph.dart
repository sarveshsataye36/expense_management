import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'bar_data.dart';

class ExpenseBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thruAmount;
  final double friAmount;
  final double satAmount;
  const ExpenseBarGraph({super.key, this.maxY, required this.sunAmount, required this.monAmount, required this.tueAmount, required this.wedAmount, required this.thruAmount, required this.friAmount, required this.satAmount});

  @override
  Widget build(BuildContext context) {
    // initiation of bar data
    BarData barData = BarData(sunAmount, monAmount, tueAmount, wedAmount, thruAmount, friAmount, satAmount);
    //
    barData.initializedBarData();
    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTiles,
          ))
        ),
        barGroups: barData.barData.map((data) => BarChartGroupData(x: data.x,
        barRods: [
          BarChartRodData(
            toY: data.y,
            color: Colors.grey[800],
            width: 25,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxY,
              color: Colors.grey[200]
            ),
          )
        ]
        )).toList(),
      )
    );
  }
}

Widget getBottomTiles(double value , TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14
  );
   Widget text;
   switch (value.toInt()){
     case 0 :
       text = const Text('S', style: style);
       break;
     case 1 :
       text = const Text('M', style: style);
       break;
     case 2 :
       text = const Text('T', style: style);
       break;
     case 3 :
       text = const Text('W', style: style);
       break;
     case 4 :
       text = const Text('T', style: style);
       break;
     case 5 :
       text = const Text('F', style: style);
       break;
     case 6 :
       text = const Text('S', style: style);
       break;
     default:
       text = const Text('', style: style);
       break;
   }
   return SideTitleWidget(axisSide: meta.axisSide, child: text);

}
