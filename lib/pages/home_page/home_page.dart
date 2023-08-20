// import 'package:expense_management/components/expense_summary.dart';
// import 'package:expense_management/components/expense_tiles.dart';
// import 'package:expense_management/data/expense_data.dart';
// import 'package:expense_management/module/expense_item.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // text controller
//   final newExpenseNameController = TextEditingController();
//   final newExpenseAmountController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<ExpenseData>(context,listen: false).prepareData();
//   }
//
//   // Add new expense
//   void addNewExpense(){
//     showDialog(context: context,
//         builder:(context)=> AlertDialog(
//           title: const Text('Add new Expense'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 controller: newExpenseNameController,
//                   decoration : const InputDecoration(
//                       hintText: "Expense name",
//                   ),
//               ),
//               TextField(
//                 controller: newExpenseAmountController,
//                 keyboardType: TextInputType.number,
//                 decoration : const InputDecoration(
//                   hintText: "Expense amount",
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             MaterialButton(onPressed: saveExpense,
//               child: const Text('Save'),),
//             MaterialButton(onPressed: cancelExpense,
//               child: const Text('Cancel'),),
//           ],
//         ) );
//   }
//   //
//   //
//   void updateCurrentExpense(ExpenseItem expense,String name, String amount){
//     newExpenseNameController.text = name;
//     newExpenseAmountController.text = amount;
//     showDialog(context: context,
//         builder:(context)=> AlertDialog(
//           title: const Text('Update Expense'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 controller: newExpenseNameController,
//                 decoration : const InputDecoration(
//                   hintText: "Expense name",
//                 ),
//               ),
//               TextField(
//                 controller: newExpenseAmountController,
//                 keyboardType: TextInputType.number,
//                 decoration : const InputDecoration(
//                   hintText: "Expense amount",
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             MaterialButton(onPressed:()=>updateExpense(expense),
//               child: const Text('Update'),),
//             MaterialButton(onPressed: cancelExpense,
//               child: const Text('Cancel'),),
//           ],
//         ) );
//   }
//   //
//   //
//   void saveExpense(){
//     //
//     if(newExpenseNameController.text.isNotEmpty && newExpenseAmountController.text.isNotEmpty){
//       // create new Expense
//       ExpenseItem newExpense = ExpenseItem(
//           name: newExpenseNameController.text,
//           amount: newExpenseAmountController.text,
//           dateTime: DateTime.now(),
//           type: 'Expense'
//       );
//       // Add new expense
//       Provider.of<ExpenseData>(context,listen: false).addNewExpense(newExpense);
//     }
//     Navigator.pop(context); // Remove the dialog box
//     clearText();
//   }
//   //
//   void updateExpense(expense){
//     // Updating expense Item
//     String name = newExpenseNameController.text;
//     String amount = newExpenseAmountController.text;
//     DateTime dateTime = expense.dateTime;
//
//     if(newExpenseNameController.text.isNotEmpty && newExpenseAmountController.text.isNotEmpty){
//       // create new Expense
//       ExpenseItem newExpense = ExpenseItem(
//           name: name,
//           amount: amount,
//           dateTime: dateTime,
//           type: 'expense'
//       );
//       //
//       Provider.of<ExpenseData>(context,listen: false).updateExpense(expense,newExpense);
//       //
//     }
//     //
//     Navigator.pop(context); // Remove the dialog box
//     clearText();
//     // print(expense);
//     // print(amount);
//   }
//   //
//   void cancelExpense(){
//     Navigator.pop(context); // Remove the dialog box
//     clearText();
//   }
//   //
//   void clearText(){
//     newExpenseAmountController.clear();
//     newExpenseNameController.clear();
//   }
//   //
//   void deleteExpense(ExpenseItem expense){
//     Provider.of<ExpenseData>(context,listen: false).deleteExpense(expense);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ExpenseData>(builder: (context, value, child)=>Scaffold(
//       backgroundColor: Colors.grey[300],
//       floatingActionButton: FloatingActionButton(onPressed: addNewExpense,
//         backgroundColor: Colors.black54,
//         child: const Icon(Icons.add),),
//       body: ListView(
//         children: [
//           //
//
//           const SizedBox(
//             height: 10,
//           ),
//           // Weekly summary
//           ExpenseSummary(startOfTheWeek: value.startOfWeekDate()),
//           // Expense list
//           const SizedBox(
//             height: 25,
//           ),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: value.getAllExpenseList().length,
//             itemBuilder: (context,index)=>ExpenseTiles(
//                 expenseName: value.getAllExpenseList()[index].name,
//                 expenseAmount: value.getAllExpenseList()[index].amount,
//                 expenseDateTime: value.getAllExpenseList()[index].dateTime,
//                 type:value.getAllExpenseList()[index].type,
//                 deleteTapped: (p0)=>deleteExpense(value.getAllExpenseList()[index]),
//                 editTapped: (p0)=>updateCurrentExpense(value.getAllExpenseList()[index],value.getAllExpenseList()[index].name,value.getAllExpenseList()[index].amount),
//             ),
//           ),
//         ],
//       ),
//     ),
//     );
//   }
// }
