import 'package:expense_management/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'helpers/constant.dart';
import 'pages/dashboard.dart';
import 'pages/home_page/home_page.dart';

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
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Dashboard(),
      ),
    );
  }
}
