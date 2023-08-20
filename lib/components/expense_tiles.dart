import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../data/expense_curd.dart';

class ExpenseTiles extends StatelessWidget {
  final String expenseName;
  final String expenseAmount;
  final String type;
  final DateTime expenseDateTime;
  final void Function(BuildContext)? deleteTapped;
  final void Function(BuildContext)? editTapped;
  final expenseCurd = ExpenseCurd();
   ExpenseTiles({super.key, required this.expenseName, required this.expenseAmount, required this.expenseDateTime,required this.type, required this.deleteTapped, required this.editTapped});


  @override
  Widget build(BuildContext context) {
    String currentCurrency = expenseCurd.readCurrency();
    return Slidable(
      endActionPane: ActionPane(
        motion:  const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: editTapped,
            icon: Icons.edit,
            backgroundColor: Colors.green,
          ),
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.redAccent,
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            border: const Border(bottom: BorderSide(color: Colors.white))),
        child: ListTile(
          title: Text(expenseName,style: const TextStyle(fontWeight: FontWeight.w600),),
          subtitle: Text('${expenseDateTime.day}/${expenseDateTime.month}/${expenseDateTime.year}'),
          trailing: type == 'Expense' ? Text('- $currentCurrency$expenseAmount',style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w600),) : Text('+ $currentCurrency$expenseAmount',style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
        ),
      ),
    );
  }
}
