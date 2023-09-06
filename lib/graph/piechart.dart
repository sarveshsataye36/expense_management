import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../components/indicator.dart';

class PieChartTotal extends StatelessWidget {
  final double incomeVal;
  final double expenseVal;
  const PieChartTotal({required this.incomeVal, required this.expenseVal, super.key});

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
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: income,
            title: income.toStringAsFixed(2) + '%',
            titleStyle: const TextStyle(
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
            titleStyle: const TextStyle(
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