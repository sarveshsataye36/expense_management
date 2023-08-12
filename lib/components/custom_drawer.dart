import 'package:flutter/material.dart';

import 'menu_item.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            width: double.infinity,
            height: 120,
            child: Image.asset(
              'lib/icons/spending.png',
              fit: BoxFit.cover, // Fixes border issues
            ),
          ),
          const Divider(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          MenuItem(title: 'Dashboard', icon: Icons.dashboard_rounded, onTapFunction: (){}),
          const SizedBox(
            height: 10,
          ),
          MenuItem(title: 'Income', icon: Icons.arrow_upward_rounded, onTapFunction: (){}),
          const SizedBox(
            height: 10,
          ),
          MenuItem(title: 'Expense', icon: Icons.arrow_downward_rounded, onTapFunction: (){}),
          const SizedBox(
            height: 10,
          ),
          MenuItem(title: 'About', icon: Icons.info_outline_rounded, onTapFunction: (){}),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
