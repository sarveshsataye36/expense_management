import 'package:expense_management/helpers/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComponentTitle extends StatelessWidget {
  String title;
  ComponentTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(title,
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          color: textColor
      ),
    ),
      ],
    );
  }
}
