import 'package:expense_management/helpers/date_time_helper.dart';
import 'package:flutter/cupertino.dart';
import '../module/expense_item.dart';

class ExpenseData extends ChangeNotifier{
  // List of all expense
  List<ExpenseItem> overAllExpenseList = [];

  // Get expense list
  List<ExpenseItem> getAllExpenseList(){
    return overAllExpenseList;
  }

  // Add new expense
  void addNewExpense(ExpenseItem newExpense){
    overAllExpenseList.add(newExpense);
    notifyListeners();
  }

  // Delete the expense
  void deleteExpense(ExpenseItem expense){
    overAllExpenseList.remove(expense);
    notifyListeners();
  }
  // Update the expense
  void updateExpense(ExpenseItem expense){
    overAllExpenseList.remove(expense);
    notifyListeners();
  }

  // Get weekend (mon, tue, ect) from DateTime object
  String getDayName(DateTime dateTime){
    switch(dateTime.weekday){
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thru';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // Get the date for start of the week
  DateTime startOfWeekDate(){
    DateTime? startOfWeek;

    // get today's date
    DateTime today = DateTime.now();

    // go backward from today to find sunday
    for(int i = 0; i < 7; i++){
      if(getDayName(today.subtract(Duration(days: i))) == 'Sun'){
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    if (startOfWeek == null){
      return DateTime.now();
    }else{
      return startOfWeek;
    }

  }

  // Convert overall list of expense into daily expense summary
  Map<String, double> calculateDailyExpenseSummary(){
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overAllExpenseList){
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      }else{
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }

}