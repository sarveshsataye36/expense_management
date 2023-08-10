import 'package:expense_management/components/total_balance.dart';
import 'package:expense_management/module/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/components_title.dart';
import '../components/empty_transaction.dart';
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

  // text controller
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context,listen: false).prepareData();
  }

  @override
  void dispose() {
    newExpenseNameController.dispose();
    newExpenseAmountController.dispose();
    super.dispose();
  }
  // Add new expense
  void addNewExpense(){
    showDialog(context: context,
        builder:(context)=> AlertDialog(
          title: const Text('Add new Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: newExpenseNameController,
                decoration : const InputDecoration(
                  hintText: "Expense name",
                ),
              ),
              TextField(
                controller: newExpenseAmountController,
                keyboardType: TextInputType.number,
                decoration : const InputDecoration(
                  hintText: "Expense amount",
                ),
              ),
            ],
          ),
          actions: [
            MaterialButton(onPressed: saveExpense,
              child: const Text('Save'),),
            MaterialButton(onPressed: cancelExpense,
              child: const Text('Cancel'),),
          ],
        ) );
  }

  // Update current expense
  void updateCurrentExpense(ExpenseItem expense,String name, String amount){
    newExpenseNameController.text = name;
    newExpenseAmountController.text = amount;
    showDialog(context: context,
        builder:(context)=> AlertDialog(
          title: const Text('Update Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: newExpenseNameController,
                decoration : const InputDecoration(
                  hintText: "Expense name",
                ),
              ),
              TextField(
                controller: newExpenseAmountController,
                keyboardType: TextInputType.number,
                decoration : const InputDecoration(
                  hintText: "Expense amount",
                ),
              ),
            ],
          ),
          actions: [
            MaterialButton(onPressed:()=>updateExpense(expense),
              child: const Text('Update'),),
            MaterialButton(onPressed: cancelExpense,
              child: const Text('Cancel'),),
          ],
        ) );
  }

  // Save Expense
  void saveExpense(){
    if(newExpenseNameController.text.isNotEmpty && newExpenseAmountController.text.isNotEmpty){
      // create new Expense
      ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: newExpenseAmountController.text,
          dateTime: DateTime.now()
      );

      // Add new expense
      Provider.of<ExpenseData>(context,listen: false).addNewExpense(newExpense);
    }

    Navigator.pop(context); // Remove the dialog box
    clearText();
  }

  // Update Expense
  void updateExpense(expense){
    // Updating expense Item
    String name = newExpenseNameController.text;
    String amount = newExpenseAmountController.text;
    DateTime dateTime = expense.dateTime;

    if(newExpenseNameController.text.isNotEmpty && newExpenseAmountController.text.isNotEmpty){
      // create new Expense
      ExpenseItem newExpense = ExpenseItem(
          name: name,
          amount: amount,
          dateTime: dateTime
      );
      //
      Provider.of<ExpenseData>(context,listen: false).updateExpense(expense,newExpense);
      //
    }

    Navigator.pop(context); // Remove the dialog box
    clearText();
  }

  // cancel expense model
  void cancelExpense(){
    Navigator.pop(context); // Remove the dialog box
    clearText();
  }

  // clear text control
  void clearText(){
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  // Delete Expense
  void deleteExpense(ExpenseItem expense){
    Provider.of<ExpenseData>(context,listen: false).deleteExpense(expense);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(builder: (context, value, child)=>Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: addNewExpense,
          backgroundColor: Colors.black54,
          child: const Icon(Icons.add)
        ),
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
              const SizedBox(
                height: 20,
              ),
              // Recent Transaction
              ComponentTitle(title: 'Recent Transaction'),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: value.getAllExpenseList().isEmpty ? const NoTransaction() : ListView.builder(
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
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
