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

class MonthIncome extends StatefulWidget {
  const MonthIncome({super.key});

  @override
  State<MonthIncome> createState() => _MonthIncomeState();
}

class _MonthIncomeState extends State<MonthIncome> {
  // text controller
  final newIncomeNameController = TextEditingController();
  final newIncomeAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  @override
  void dispose() {
    newIncomeNameController.dispose();
    newIncomeAmountController.dispose();
    super.dispose();
  }

  bool switchValue = true;

  // Add new Income
  void addNewIncome() {
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
                      Text('Income',
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
                    controller: newIncomeNameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: newIncomeAmountController,
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
                        onPressed: saveIncome,
                        color: greenColor,
                        elevation: 0,
                        padding: const EdgeInsets.fromLTRB(20,16,20,16),
                        child: const Text('Save'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      MaterialButton(
                        onPressed: cancelIncome,
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

  // Update current Income
  void updateCurrentIncome(ExpenseItem income, String name, String amount, String type) {
    newIncomeNameController.text = name;
    newIncomeAmountController.text = amount;
    if(type == 'Income'){
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
                      Text('Income',
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
                    controller: newIncomeNameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: newIncomeAmountController,
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
                        onPressed: ()=>updateIncome(income),
                        color: greenColor,
                        elevation: 0,
                        padding: const EdgeInsets.fromLTRB(20,16,20,16),
                        child: const Text('Update'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      MaterialButton(
                        onPressed: cancelIncome,
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

  // Save Income
  void saveIncome() {
    String type;
    if (!newIncomeAmountController.text.contains('-') && newIncomeNameController.text.isNotEmpty &&
        newIncomeAmountController.text.isNotEmpty) {
      if(switchValue != true){
        type = 'Income';
      }else{
        type = 'Income';
      }
      // create new Income
      ExpenseItem newIncome = ExpenseItem(
          name: newIncomeNameController.text,
          amount: newIncomeAmountController.text,
          type: type,
          dateTime: DateTime.now());

      // Add new Income
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newIncome);
    }
    Provider.of<ExpenseData>(context, listen: false).totalBalance();
    Navigator.pop(context); // Remove the dialog box
    clearText();
  }

  // Update Income
  void updateIncome(income) {
    // Updating Income Item
    String name = newIncomeNameController.text;
    String amount = newIncomeAmountController.text;
    DateTime dateTime = income.dateTime;
    String type;
    if(switchValue != true){
      type = 'Income';
    }else{
      type = 'Income';
    }
    if (!newIncomeAmountController.text.contains('-') && newIncomeNameController.text.isNotEmpty &&
        newIncomeAmountController.text.isNotEmpty) {
      // create new Income
      ExpenseItem newIncome =
      ExpenseItem(name: name, amount: amount, type: type,dateTime: dateTime);
      //
      Provider.of<ExpenseData>(context, listen: false)
          .updateExpense(income, newIncome);
      //
    }
    Provider.of<ExpenseData>(context, listen: false).totalBalance();
    Navigator.pop(context); // Remove the dialog box
    clearText();
  }

  // cancel Income model
  void cancelIncome() {
    Navigator.pop(context); // Remove the dialog box
    clearText();
  }

  // clear text control
  void clearText() {
    newIncomeAmountController.clear();
    newIncomeNameController.clear();
  }

  // Delete Income
  void deleteIncome(ExpenseItem income) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(income);
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
                            TopMenuItemCard(title: 'Total Income', subTitle: value.totalIncome().toString(), active: false, onTapFunction: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/income/income_dashboard');
                            },),
                            const SizedBox(
                              width: 10,
                            ),
                            TopMenuItemCard(title: 'Weekly Income', subTitle: value.dateWiseTransactionTotal('Income','week').toString(), active: false, onTapFunction: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/income/week_income');
                            },),
                            const SizedBox(
                              width: 10,
                            ),
                            TopMenuItemCard(title: 'Monthly Income', subTitle: value.dateWiseTransactionTotal('Income','month').toString(), active: true, onTapFunction: () { },),
                            const SizedBox(
                              width: 10,
                            ),
                            TopMenuItemCard(title: 'Yearly Income', subTitle: value.dateWiseTransactionTotal('Income','year').toString(), active: false, onTapFunction: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/income/year_income');
                            },),
                          ]
                      )
                  ),
                  //
                  const SizedBox(
                    height: 20,
                  ),
                  const ComponentTitle(title: 'Income List'),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: value.dateWiseTransactionList('month').isEmpty
                          ? const NoTransaction()
                          : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.dateWiseTransactionList('month').length,
                        itemBuilder: (context, index) => value.dateWiseTransactionList('month')[index].type == 'Income' ? ExpenseTiles(
                          expenseName:value.dateWiseTransactionList('month')[index].name,
                          expenseAmount:value.dateWiseTransactionList('month')[index].amount,
                          expenseDateTime:value.dateWiseTransactionList('month')[index].dateTime,
                          type:value.dateWiseTransactionList('month')[index].type,
                          deleteTapped: (p0) => deleteIncome(value.dateWiseTransactionList('month')[index]),
                          editTapped: (p0) => updateCurrentIncome(
                            value.dateWiseTransactionList('month')[index],
                            value.dateWiseTransactionList('month')[index].name,
                            value.dateWiseTransactionList('month')[index].amount,
                            value.dateWiseTransactionList('month')[index].type,
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
