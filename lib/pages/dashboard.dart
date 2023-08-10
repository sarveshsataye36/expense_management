import 'package:expense_management/components/total_balance.dart';
import 'package:expense_management/module/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/expense_tiles.dart';
import '../components/header.dart';
import '../components/total_income_expense.dart';
import '../data/expense_data.dart';
import '../helpers/constant.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(builder: (context, value, child)=>Scaffold(
        backgroundColor: lightRedBackground,
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              // App bar with heading
              const HeaderUi(),
              //
              const SizedBox(
                height: 20,
              ),

             // Total Balance
              const TotalBalanceUi(),
             //
              const SizedBox(
                height: 20,
              ),

              // Total Expense & Income
              const TotalIncomeExpenseUi(),
              //

              // Recent Transaction
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context,index)=>ExpenseTiles(
                  expenseName: value.getAllExpenseList()[index].name,
                  expenseAmount: value.getAllExpenseList()[index].amount,
                  expenseDateTime: value.getAllExpenseList()[index].dateTime,
                  deleteTapped: (p0)=>deleteExpense(value.getAllExpenseList()[index]),
                   editTapped: (p0)=>updateCurrentExpense(value.getAllExpenseList()[index],value.getAllExpenseList()[index].name,value.getAllExpenseList()[index].amount),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  deleteExpense(ExpenseItem allExpenseList) {}

  updateCurrentExpense(ExpenseItem allExpenseList, String name, String amount) {}
}
