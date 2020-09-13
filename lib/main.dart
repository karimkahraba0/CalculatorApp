import 'package:flutter/material.dart';
import 'screens/calculation_screen.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Basic Calculator',
      home: Scaffold(
        body: Calculation(),
      ),
    );
  }
}
