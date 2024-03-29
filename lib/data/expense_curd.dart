import 'package:hive/hive.dart';
import '../helpers/constant.dart';
import '../module/expense_item.dart';

class ExpenseCurd{
  // reference the box
  final _myBox = Hive.box(databaseName);

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
        expense.type,
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
      String type = saveExpenses[i][2];
      DateTime dateTime = saveExpenses[i][3];

      ExpenseItem expense = ExpenseItem(name: name, amount: amount, type: type, dateTime: dateTime);
      allExpense.add(expense);
    }
    return allExpense;
  }

  void saveCurrency(String currency){
    String currentCurrency;
    if(currency == '₹ Rupee'){
      currentCurrency = '₹';
    }else if(currency == '\$ Dollar'){
      currentCurrency = '\$';
    }else{
      currentCurrency = '€';
    }
    _myBox.put("CURRENCY", currentCurrency);
  }

  String readCurrency(){
    String currency = _myBox.get("CURRENCY") ?? '₹';
    return currency;
  }
}
