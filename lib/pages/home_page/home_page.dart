import 'package:expense_management/components/expense_summary.dart';
import 'package:expense_management/components/expense_tiles.dart';
import 'package:expense_management/data/expense_data.dart';
import 'package:expense_management/module/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

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
  //
  void saveExpense(){
    //
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
  //
  void cancelExpense(){
    Navigator.pop(context); // Remove the dialog box
    clearText();
  }
  //
  void clearText(){
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }
  //
  void deleteExpense(ExpenseItem expense){
    Provider.of<ExpenseData>(context,listen: false).deleteExpense(expense);
  }
  //
  void updateExpense(ExpenseItem expense){
    Provider.of<ExpenseData>(context,listen: false).updateExpense(expense);
  }
  //
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(builder: (context, value, child)=>Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(onPressed: addNewExpense,
        backgroundColor: Colors.black54,
        child: const Icon(Icons.add),),
      body: ListView(
        children: [
          //

          const SizedBox(
            height: 10,
          ),
          // Weekly summary
          ExpenseSummary(startOfTheWeek: value.startOfWeekDate()),
          // Expense list
          const SizedBox(
            height: 25,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.getAllExpenseList().length,
            itemBuilder: (context,index)=>ExpenseTiles(
                expenseName: value.getAllExpenseList()[index].name,
                expenseAmount: value.getAllExpenseList()[index].amount,
                expenseDateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped: (p0)=>deleteExpense(value.getAllExpenseList()[index]),
                editTapped: (p0)=>updateExpense(value.getAllExpenseList()[index]),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
