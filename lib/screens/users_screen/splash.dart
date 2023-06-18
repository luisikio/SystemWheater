import 'package:flutter/material.dart';

class SpashScreen extends StatelessWidget {
  const SpashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 21, 29),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
