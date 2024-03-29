import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/expense_curd.dart';
import '../helpers/constant.dart';

class TotalIncomeExpenseUi extends StatelessWidget {
  final double income;
  final double expense;
  TotalIncomeExpenseUi({super.key, required this.income, required this.expense});
  final expenseCurd = ExpenseCurd();
  @override
  Widget build(BuildContext context) {
    String currentCurrency = expenseCurd.readCurrency();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: textColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Icon(Icons.arrow_downward_rounded,
                size: 30,
                color: Colors.green,
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Income',
                    style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        color: Colors.white
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('$currentCurrency$income',
                    style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        color: Colors.white
                    ),
                  ),
                ],
              )
            ],
          ),
          Text('|',
            style: GoogleFonts.inter(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 20,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: Colors.white
            ),),
          Row(
            children: [
              const Icon(Icons.arrow_upward_rounded,
                size: 30,
                color: Colors.red,
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Expense',
                    style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        color: Colors.white
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('$currentCurrency$expense',
                    style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        color: Colors.white
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}


