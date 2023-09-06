import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../components/indicator.dart';

class PieChartTotal extends StatefulWidget {
  final double income;
  final double expense;
  const PieChartTotal({super.key, required this.income, required this.expense});
  @override
  State<StatefulWidget> createState() => PieChartTotalState(income,expense);
}

class PieChartTotalState extends State {
  int touchedIndex = -1;
  PieChartTotalState(this.incomeVal, this.expenseVal);
  final double incomeVal;
  final double expenseVal;
  @override
  Widget build(BuildContext context) {
    double total = incomeVal + expenseVal;
    double incomePer = (incomeVal/total)*100;
    double expensePer = (expenseVal/total)*100;
    return AspectRatio(
      aspectRatio: 1.6,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 0,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(incomePer,expensePer),
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: Colors.redAccent,
                text: 'Expense',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.green,
                text: 'Income',
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(income,expense) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: income,
            title: income.toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.redAccent,
            value: expense,
            title: expense.toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}