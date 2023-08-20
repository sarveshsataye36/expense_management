import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/expense_curd.dart';
class TopMenuItemCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTapFunction;
  TopMenuItemCard({super.key, required this.title, required this.subTitle, required this.onTapFunction});
  final expenseCurd = ExpenseCurd();
  @override
  Widget build(BuildContext context) {
    String currentCurrency = expenseCurd.readCurrency();
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        width: 160,
        height: 70,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xD9C9C9CB)),
            borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
              fontSize: 16.0,
            ),),
            const SizedBox(
              height: 5,
            ),
            Text('$currentCurrency$subTitle',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
