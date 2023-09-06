import 'package:expense_management/data/expense_curd.dart';
import 'package:expense_management/helpers/date_time_helper.dart';
import 'package:flutter/cupertino.dart';
import '../module/expense_item.dart';

class ExpenseData extends ChangeNotifier{
  // expenseCurd object that connected to hive database
  final expenseCurd = ExpenseCurd();

  // List of all expense
  List<ExpenseItem> overAllExpenseList = [];

  // Get expense list
  List<ExpenseItem> getAllExpenseList(){
    return overAllExpenseList.reversed.toList();
  }
  // Prepare data to display on launch form db
  void prepareData(){
    if(expenseCurd.readData().isNotEmpty){
      overAllExpenseList = expenseCurd.readData().reversed.toList();
    }
  }

  // List by week, month, year
  List<ExpenseItem> dateWiseTransactionList(type){
    List<ExpenseItem> changeTransactionList = [];
    DateTime now = DateTime.now();
    DateTime transactionDateType;
    if(type == 'month'){
       transactionDateType = DateTime(now.month);
    }else if(type == 'year'){
       transactionDateType = DateTime(now.year);
    }else{
       transactionDateType = now.subtract(const Duration(days: 7));
    }
    changeTransactionList.addAll(
        overAllExpenseList.
        where((element) {
          final date = element.dateTime;
          return transactionDateType.isBefore(date);
        }
        ));
    return changeTransactionList;
  }
  // Add new expense
  void addNewExpense(ExpenseItem newExpense){
    overAllExpenseList.add(newExpense);
    notifyListeners();
    // save expense data after add to overAllExpenseList
    expenseCurd.saveData(overAllExpenseList);
  }

  // Delete the expense
  void deleteExpense(ExpenseItem expense){
    overAllExpenseList.remove(expense);
    notifyListeners();
    // save expense data after delete
    expenseCurd.saveData(overAllExpenseList);
  }
  // Update the expense
  void updateExpense(ExpenseItem expense,newExpense){
    overAllExpenseList.remove(expense);
    overAllExpenseList.add(newExpense);
    notifyListeners();
    //notifyListeners();
    // save expense data after update
    expenseCurd.saveData(overAllExpenseList);
  }

  // Total balance
  double totalBalance(){
    double total = 0;
    for(var expense in overAllExpenseList){
      if(expense.type == 'Expense'){
        total -= double.parse(expense.amount);
      }else{
        total += double.parse(expense.amount);
      }
    }
    return total;
  }

  // Total expense
  double totalExpense(){
    double total = 0;
    for(var expense in overAllExpenseList){
      if(expense.type == 'Expense'){
        total += double.parse(expense.amount);
      }
    }
    return total;
  }

  // Total income
  double totalIncome(){
    double total = 0;
    for(var expense in overAllExpenseList){
      if(expense.type == 'Income'){
        total += double.parse(expense.amount);
      }
    }
    return total;
  }

  // week, month, year wise transaction total
  double dateWiseTransactionTotal(String type, String dateType){
    double total = 0;
    List dateWiseList = [];
    if(dateType == 'week'){
       dateWiseList = dateWiseTransactionList('week');
    }else if(dateType == 'month'){
       dateWiseList = dateWiseTransactionList('month');
    }else{
       dateWiseList = dateWiseTransactionList('year');
    }

    for(var expense in dateWiseList){
      if(type == 'Income'){
        if(expense.type == 'Income'){
          total += double.parse(expense.amount);
        }
      }else{
        if(expense.type == 'Expense'){
          total += double.parse(expense.amount);
        }
      }

    }
    return total;
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

  // Date wise filter transaction
  List<ExpenseItem>? dateWiseFilter(DateTime startDate, DateTime endDate) {
    List<ExpenseItem> changeTransactionList = [];
    for (var expense in overAllExpenseList) {
      if (expense.dateTime.compareTo(startDate) >= 0 && expense.dateTime.compareTo(endDate) <= 0) {
        changeTransactionList.add(expense);
      }
    }
      return changeTransactionList;
    }

  // week, month, year wise transaction total
  double dateWiseFilterTransactionTotal(DateTime startDate, DateTime endDate, String totalType){
    double total = 0;
    List dateWiseFilterList = dateWiseFilter(startDate,endDate)!;
    for(var expense in dateWiseFilterList){
      if(totalType == 'Income'){
        if(expense.type == 'Income'){
          total += double.parse(expense.amount);
        }
      }else{
        if(expense.type == 'Expense'){
          total += double.parse(expense.amount);
        }
      }

    }
    return total;
  }
  }
  //
