import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'data/expense_data.dart';
import 'pages/about/about.dart';
import 'pages/analytics/analytics_dashboard.dart';
import 'pages/expense/expense_dashboard.dart';
import 'pages/expense/month_expense.dart';
import 'pages/expense/week_expense.dart';
import 'pages/expense/year_expense.dart';
import 'pages/income/income_dashboard.dart';
import 'helpers/constant.dart';
import 'pages/dashboard.dart';
import 'pages/income/year_income.dart';
import 'pages/income/month_income.dart';
import 'pages/income/week_income.dart';
import 'pages/setting/setting.dart';

void main() async{
  // Initialize hive
  await Hive.initFlutter();
  // open hive box
  await Hive.openBox(databaseName);

  runApp(const ExpenseManagementApp());
}

class ExpenseManagementApp extends StatelessWidget {
  const ExpenseManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(  // register change notifier to access expense variable and function
          create: (context) => ExpenseData() ,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/dashboard',
        routes: <String, WidgetBuilder>{
          '/dashboard': (BuildContext context) => const Dashboard(),
          '/income/income_dashboard': (BuildContext context) => const IncomeDashboard(),
          '/expense/expense_dashboard': (BuildContext context) => const ExpenseDashboard(),
          '/setting/setting': (BuildContext context) => const Setting(),
          '/about/about': (BuildContext context) => const About(),
          '/income/week_income': (BuildContext context) => const WeekIncome(),
          '/income/month_income': (BuildContext context) => const MonthIncome(),
          '/income/year_income': (BuildContext context) => const YearIncome(),
          '/expense/week_expense': (BuildContext context) => const WeekExpense(),
          '/expense/month_expense': (BuildContext context) => const MonthExpense(),
          '/expense/year_expense': (BuildContext context) => const YearExpense(),
          '/analytics/analytics_dashboard': (BuildContext context) => const AnalyticDashboard(),
        },
        home: const Dashboard(),
      ),
    );
  }
}
