import 'package:expense_management/data/expense_data.dart';
import 'package:expense_management/graph/bar_graph.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/date_time_helper.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfTheWeek;
  const ExpenseSummary({super.key, required this.startOfTheWeek});

  // Calculate the max value of Y in graph
  double calculateMax(ExpenseData value, String sunday, String monday, String tuesday, String wednesday, String thursday, String friday, String saturday){
    double? max = 300;
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];
    // sort from smallest to largest
    values.sort();
    // get the largest value which is end of the list
    // and increase the graph max capacity

    max = values.last * 1.5;
    return max == 0 || max < 300 ? 300 : max;
  }

  // Calculate the week total
  String calculateWeekMaxAmt(ExpenseData value, String sunday, String monday, String tuesday, String wednesday, String thursday, String friday, String saturday){
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for(int i = 0; i< values.length; i++){
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }
  //
  @override
  Widget build(BuildContext context) {
    String sunday = convertDateTimeToString(startOfTheWeek.add(const Duration(days: 0)));
    String monday = convertDateTimeToString(startOfTheWeek.add(const Duration(days: 1)));
    String tuesday = convertDateTimeToString(startOfTheWeek.add(const Duration(days: 2)));
    String wednesday = convertDateTimeToString(startOfTheWeek.add(const Duration(days: 3)));
    String thursday = convertDateTimeToString(startOfTheWeek.add(const Duration(days: 4)));
    String friday = convertDateTimeToString(startOfTheWeek.add(const Duration(days: 5)));
    String saturday = convertDateTimeToString(startOfTheWeek.add(const Duration(days: 6)));
    return Consumer<ExpenseData>(
      builder: (context,value,child)=> SizedBox(
        height: 200,
        child: ExpenseBarGraph(
          maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
          sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
          monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
          tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
          wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
          thruAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
          friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
          satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
        ),
      ),
    );
  }
}
