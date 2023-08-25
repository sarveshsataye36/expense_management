import 'package:expense_management/module/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../components/components_title.dart';
import '../../components/custom_drawer.dart';
import '../../components/empty_transaction.dart';
import '../../components/expense_tiles.dart';
import '../../components/header.dart';
import '../../components/top_menu_card.dart';
import '../../data/expense_data.dart';
import '../../helpers/constant.dart';

class WeekExpense extends StatefulWidget {
  const WeekExpense({super.key});

  @override
  State<WeekExpense> createState() => WeekExpenseState();
}

class WeekExpenseState extends State<WeekExpense> {
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

  // Add new Expense
  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ComponentTitle(title: 'Add Transaction'),

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
                      Text('Expense',
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

  // Update current Expense
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
                  const ComponentTitle(title: 'Update Transaction'),

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
                      Text('Expense',
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
        type = 'Expense';
      }
      // create new Expense
      ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: newExpenseAmountController.text,
          type: type,
          dateTime: DateTime.now());

      // Add new Expense
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }
    Provider.of<ExpenseData>(context, listen: false).totalBalance();
    Navigator.pop(context); // Remove the dialog box
    clearText();
  }

  // Update Expense
  void updateExpense(expense) {
    // Updating Expense Item
    String name = newExpenseNameController.text;
    String amount = newExpenseAmountController.text;
    DateTime dateTime = expense.dateTime;
    String type;
    if(switchValue != true){
      type = 'Expense';
    }else{
      type = 'Expense';
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

  // cancel Expense model
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
    return SafeArea(
        child: Consumer<ExpenseData>(builder: (context, value, child)=>Scaffold(
            backgroundColor: lightRedBackground,
            drawer: const CustomDrawer(),
            body: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(children: [
                  // App bar with heading
                  const HeaderUi(),
                  //
                  const SizedBox(
                    height: 14,
                  ),
                  //
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TopMenuItemCard(title: 'Total Expense', subTitle: value.totalExpense().toString(), active: false, onTapFunction: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/expense/expense_dashboard');
                            },),
                            const SizedBox(
                              width: 10,
                            ),
                            TopMenuItemCard(title: 'Weekly Expense', subTitle: value.dateWiseTransactionTotal('Expense','week').toString(), active: true, onTapFunction: () {},),
                            const SizedBox(
                              width: 10,
                            ),
                            TopMenuItemCard(title: 'Monthly Expense', subTitle: value.dateWiseTransactionTotal('Expense','month').toString(), active: false, onTapFunction: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/expense/month_expense');
                            },),
                            const SizedBox(
                              width: 10,
                            ),
                            TopMenuItemCard(title: 'Yearly Expense', subTitle: value.dateWiseTransactionTotal('Expense','year').toString(), active: false, onTapFunction: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/expense/year_expense');
                            },),
                          ]
                      )
                  ),
                  //
                  const SizedBox(
                    height: 20,
                  ),
                  const ComponentTitle(title: 'Expense List'),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: value.dateWiseTransactionList('week').isEmpty
                          ? const NoTransaction()
                          : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.dateWiseTransactionList('week').length,
                        itemBuilder: (context, index) => value.dateWiseTransactionList('week')[index].type == 'Expense' ? ExpenseTiles(
                          expenseName:value.dateWiseTransactionList('week')[index].name,
                          expenseAmount:value.dateWiseTransactionList('week')[index].amount,
                          expenseDateTime:value.dateWiseTransactionList('week')[index].dateTime,
                          type:value.dateWiseTransactionList('week')[index].type,
                          deleteTapped: (p0) => deleteExpense(value.dateWiseTransactionList('week')[index]),
                          editTapped: (p0) => updateCurrentExpense(
                            value.dateWiseTransactionList('week')[index],
                            value.dateWiseTransactionList('week')[index].name,
                            value.dateWiseTransactionList('week')[index].amount,
                            value.dateWiseTransactionList('week')[index].type,
                          ),
                        ) : const SizedBox(
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ])))));
  }
}
