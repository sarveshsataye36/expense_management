import 'package:expense_management/data/expense_data.dart';
import 'pages/about/about.dart';
import 'pages/expense/expense_dashboard.dart';
import 'pages/income/income_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'helpers/constant.dart';
import 'pages/dashboard.dart';
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
        },
        home: const Dashboard(),
      ),
    );
  }
}
