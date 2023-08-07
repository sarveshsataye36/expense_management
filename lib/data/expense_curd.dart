import 'package:hive/hive.dart';
import '../module/expense_item.dart';

class ExpenseCurd{
  // reference the box
  final _myBox = Hive.box('expense_management');

  // Write the Data
  void saveData(List<ExpenseItem> allExpense){
    /*
    * Hive can only store strings, list, Map and dateTime not custom object like expenseItem
    *
    * converting object to list to store in hive
    *
    */

    List<List<dynamic>> allExpenseFormatted = [];

    for(var expense in allExpense){
      List<dynamic>  expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpenseFormatted.add(expenseFormatted);
    }

    // Store the list in database
    _myBox.put("ALl_EXPENSE", allExpenseFormatted);

  }

  // Read the Data
  List<ExpenseItem> readData(){

    List saveExpenses = _myBox.get("ALl_EXPENSE") ?? [];
    List<ExpenseItem> allExpense = [];

    for(int i=0; i<saveExpenses.length; i++){
      String name = saveExpenses[i][0];
      String amount = saveExpenses[i][1];
      DateTime dateTime = saveExpenses[i][2];

      ExpenseItem expense = ExpenseItem(name: name, amount: amount, dateTime: dateTime);
      allExpense.add(expense);
    }
    return allExpense;
  }
}
