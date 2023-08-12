import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helpers/constant.dart';
class HeaderUi extends StatelessWidget {
  const HeaderUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            Scaffold.of(context).openDrawer();
          },
          child: Image.asset(
            'lib/icons/menu-icon.png',
            fit: BoxFit.cover, // Fixes border issues
            width: 34.0,
            height: 34.0,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text('Spending.io',
            style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 25,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: textColor
            )
        )
      ],
    );
  }
}
