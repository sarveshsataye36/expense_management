import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTapFunction;

  const MenuItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTapFunction});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 10, 10, 10),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 18,
              color: Colors.grey[800],
            ),
            const SizedBox(
              width: 22,
            ),
            Text(
              title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
