import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class ExpenseTiles extends StatelessWidget {
  final String expenseName;
  final String expenseAmount;
  final DateTime expenseDateTime;
  void Function(BuildContext)? deleteTapped;
  void Function(BuildContext)? editTapped;

   ExpenseTiles({super.key, required this.expenseName, required this.expenseAmount, required this.expenseDateTime, required this.deleteTapped});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 1),
      child: Slidable(
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
        child: ListTile(
          tileColor: Colors.white70,
          title: Text(expenseName),
          subtitle: Text('${expenseDateTime.day}/${expenseDateTime.month}/${expenseDateTime.year}'),
          trailing: Text('₹ $expenseAmount'),
        ),
      ),
    );
  }
}
