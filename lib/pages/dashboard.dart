import 'package:expense_management/components/total_balance.dart';
import 'package:expense_management/module/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  @override
  void dispose() {
    newExpenseNameController.dispose();
    newExpenseAmountController.dispose();
    super.dispose();
  }

  bool switchValue = true;

  // Add new expense
  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ComponentTitle(title: 'Add Transaction'),

                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Expense',
                        style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            color: textColor
                        ),),
                      CupertinoSwitch(
                        value: switchValue,
                        onChanged: (value) {
                          setState(() {
                            switchValue = value;
                          });
                        },
                      ),
                      Text('Income',
                        style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            color: textColor
                        ),),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: newExpenseNameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: newExpenseAmountController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return value!.contains('-') ? 'Do not use the - ' : null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Amount",
                      border: OutlineInputBorder(borderSide: BorderSide()),

                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: saveExpense,
                        color: greenColor,
                        elevation: 0,
                        padding: const EdgeInsets.fromLTRB(20,16,20,16),
                        child: const Text('Save'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      MaterialButton(
                        onPressed: cancelExpense,
                        elevation: 0,
                        padding: const EdgeInsets.fromLTRB(20,16,20,16),
                        color: Colors.grey[100],
                        child: const Text('Cancel'),
                      ),
                    ],
                  )
                ],
              );
            })));
  }

  // Update current expense
  void updateCurrentExpense(ExpenseItem expense, String name, String amount, String type) {
    newExpenseNameController.text = name;
    newExpenseAmountController.text = amount;
    if(type == 'Expense'){
      switchValue = false;
    }else{
      switchValue = true;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ComponentTitle(title: 'Update Transaction'),

                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Expense',
                        style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            color: textColor
                        ),),
                      CupertinoSwitch(
                        value: switchValue,
                        onChanged: (value) {
                          setState(() {
                            switchValue = value;
                          });
                        },
                      ),
                      Text('Income',
                        style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            color: textColor
                        ),),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: newExpenseNameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: newExpenseAmountController,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (updateValue) {
                      return updateValue!.contains('-') ? 'Do not use the - ' : null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Amount",
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: ()=>updateExpense(expense),
                        color: greenColor,
                        elevation: 0,
                        padding: const EdgeInsets.fromLTRB(20,16,20,16),
                        child: const Text('Update'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      MaterialButton(
                        onPressed: cancelExpense,
                        elevation: 0,
                        padding: const EdgeInsets.fromLTRB(20,16,20,16),
                        color: Colors.grey[100],
                        child: const Text('Cancel'),
                      ),
                    ],
                  )
                ],
              );
            })));
  }

  // Save Expense
  void saveExpense() {
    String type;
    if (!newExpenseAmountController.text.contains('-') && newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      if(switchValue != true){
        type = 'Expense';
      }else{
        type = 'Income';
      }
      // create new Expense
      ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: newExpenseAmountController.text,
          type: type,
          dateTime: DateTime.now());

      // Add new expense
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }
    Provider.of<ExpenseData>(context, listen: false).totalBalance();
    Navigator.pop(context); // Remove the dialog box
    clearText();
  }

  // Update Expense
  void updateExpense(expense) {
    // Updating expense Item
    String name = newExpenseNameController.text;
    String amount = newExpenseAmountController.text;
    DateTime dateTime = expense.dateTime;
    String type;
    if(switchValue != true){
      type = 'Expense';
    }else{
      type = 'Income';
    }
    if (!newExpenseAmountController.text.contains('-') && newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      // create new Expense
      ExpenseItem newExpense =
          ExpenseItem(name: name, amount: amount, type: type,dateTime: dateTime);
      //
      Provider.of<ExpenseData>(context, listen: false)
          .updateExpense(expense, newExpense);
      //
    }
    Provider.of<ExpenseData>(context, listen: false).totalBalance();
    Navigator.pop(context); // Remove the dialog box
    clearText();
  }

  // cancel expense model
  void cancelExpense() {
    Navigator.pop(context); // Remove the dialog box
    clearText();
  }

  // clear text control
  void clearText() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  // Delete Expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: addNewExpense,
                backgroundColor: Colors.black54,
                child: const Icon(Icons.add)),
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
                  TotalBalanceUi(
                    totalBalance: Provider.of<ExpenseData>(context, listen: false).totalBalance(),
                  ),
                  //
                  const SizedBox(
                    height: 20,
                  ),

                  // Total Expense & Income
                  TotalIncomeExpenseUi(
                    income: Provider.of<ExpenseData>(context, listen: false).totalIncome(),
                    expense: Provider.of<ExpenseData>(context, listen: false).totalExpense(),
                  ),
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
                      child: value.getAllExpenseList().isEmpty
                          ? const NoTransaction()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: value.getAllExpenseList().length,
                              itemBuilder: (context, index) => ExpenseTiles(
                                expenseName:value.getAllExpenseList()[index].name,
                                expenseAmount:value.getAllExpenseList()[index].amount,
                                expenseDateTime:value.getAllExpenseList()[index].dateTime,
                                type:value.getAllExpenseList()[index].type,
                                deleteTapped: (p0) => deleteExpense(value.getAllExpenseList()[index]),
                                editTapped: (p0) => updateCurrentExpense(
                                    value.getAllExpenseList()[index],
                                    value.getAllExpenseList()[index].name,
                                    value.getAllExpenseList()[index].amount,
                                    value.getAllExpenseList()[index].type,
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
