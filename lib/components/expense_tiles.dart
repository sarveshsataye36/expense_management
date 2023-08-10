import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class ExpenseTiles extends StatelessWidget {
  final String expenseName;
  final String expenseAmount;
  final DateTime expenseDateTime;
  void Function(BuildContext)? deleteTapped;
  void Function(BuildContext)? editTapped;

   ExpenseTiles({super.key, required this.expenseName, required this.expenseAmount, required this.expenseDateTime, required this.deleteTapped, required this.editTapped});


  @override
  Widget build(BuildContext context) {
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
          title: Text(expenseName),
          subtitle: Text('${expenseDateTime.day}/${expenseDateTime.month}/${expenseDateTime.year}'),
          trailing: Text('₹ $expenseAmount'),
        ),
      ),
    );
  }
}
