import 'package:flutter/material.dart';
class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        child: const Text('Dashboard'), onPressed: () {
        Navigator.of(context)
            .pushReplacementNamed('/dashboard');
      },
      ),
    );
  }
}
