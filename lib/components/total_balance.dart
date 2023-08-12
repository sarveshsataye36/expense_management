import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helpers/constant.dart';

class TotalBalanceUi extends StatelessWidget {
  double totalBalance;
  TotalBalanceUi({super.key,required this.totalBalance});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: textColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                padding: const EdgeInsets.fromLTRB(60, 18, 18, 18),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total balance',
                      style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                          color: Colors.white
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(totalBalance.toString(),
                      style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                          color: Colors.white
                      ),),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              right: -50,
              left: 330,
              top: -150,
              bottom: 90,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(90),
                ),
              ),
            ),
            Positioned.fill(
              left: -20,
              right: 350,
              top: 120,
              bottom: -30,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(90),
                ),
              ),
            ),
          ],
        )
    );
  }
}
