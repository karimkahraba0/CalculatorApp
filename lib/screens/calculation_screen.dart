import 'package:calculator/widgets/calculator_button.dart';
import 'package:calculator/widgets/result_display.dart';
import 'package:flutter/material.dart';

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {

  double width;
  int result;
  String operator;
  int firstOperand;
  int secondOperand;

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  //when the operator is pressed
  operatorPressed(String operator) {
    setState(() {
      //Since the default value of the first operand is null ( we consider it zero(0) )
      if (firstOperand == null) {
        firstOperand = 0;
      }
      //put the operator we will choose in operator variable
      this.operator = operator;
    });
  }


  numberPressed(int number) {
    setState(() {
      //If the previous calculation is finished (thus result is not null)
      if (result != null) {
        result = null;
        firstOperand = number;
        return;
      }
      //If the first operand is null (this is the case at the beginning or when the clear button was pressed)
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }
      //If the operator is null, pressing a number button will concat the number to the first operand
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }
      // same conditions to secondOperand
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }
      secondOperand = int.parse('$secondOperand$number');
    });
  }


  //when the result button is tapped
  calculateResult() {
    //nothing to calculate if one of them is missing.
    if (operator == null || secondOperand == null) {
      return;
    }
    //actually performing the calculation
    setState(() {
      switch (operator) {
        case '+':
          result = firstOperand + secondOperand;
          break;
        case '-':
          result = firstOperand - secondOperand;
          break;
        case '*':
          result = firstOperand * secondOperand;
          break;
        case '/':
          if (secondOperand == 0) {
            return;
          }
          //integer division
          result = firstOperand ~/ secondOperand;
          break;
      }
      // if we decide to continue calc on the latest result
      firstOperand = result;
      // all nul means equal zero and start the new calc
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  //clear to resetting every variable to null.
  clear() {
    setState(() {
      result = null;
      operator = null;
      secondOperand = null;
      firstOperand = null;
    });
  }

  //This method to show::
  String _getDisplayText() {
    //returns the result if it is not null.
    if (result != null) {
      return '$result';
    }
    //If the second operand is set, it displays the whole calculation
    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }
    //If the operator is set, it displays the first operand and the operator
    if (operator != null) {
      return '$firstOperand$operator';
    }
    //f only the first operator is set, it displays it
    if (firstOperand != null) {
      return '$firstOperand';
    }
    //if even the first operand is null
    return '0';
  }

  Widget _getButton(
      {String text,
      Function onTap,
      Color backgroundColor = Colors.white,
      Color textColor = Colors.black}) {
    return CalculatorButton(
      label: text,
      onTap: onTap,
      size: width/4-12,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ResultDisplay(
          text: _getDisplayText(),
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.01),
        Row(
          children: <Widget>[
            _getButton(text: '7', onTap: () => numberPressed(7)),
            _getButton(text: '8', onTap: () => numberPressed(8)),
            _getButton(text: '9', onTap: () => numberPressed(9)),
            _getButton(
                text: 'x',
                onTap: () => operatorPressed('*'),
                backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
          ],
        ),
        Row(
          children: <Widget>[
            _getButton(text: '4', onTap: () => numberPressed(4)),
            _getButton(text: '5', onTap: () => numberPressed(5)),
            _getButton(text: '6', onTap: () => numberPressed(6)),
            _getButton(
                text: '/',
                onTap: () => operatorPressed('/'),
                backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
          ],
        ),
        Row(
          children: <Widget>[
            _getButton(text: '1', onTap: () => numberPressed(1)),
            _getButton(text: '2', onTap: () => numberPressed(2)),
            _getButton(text: '3', onTap: () => numberPressed(3)),
            _getButton(
                text: '+',
                onTap: () => operatorPressed('+'),
                backgroundColor: Color.fromRGBO(220, 220, 220, 1))
          ],
        ),
        Row(
          children: <Widget>[
            _getButton(
                text: '=',
                onTap: calculateResult,
                backgroundColor: Colors.orange,
                textColor: Colors.white),
            _getButton(text: '0', onTap: () => numberPressed(0)),
            _getButton(
                text: 'C',
                onTap: clear,
                backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
            _getButton(
                text: '-',
                onTap: () => operatorPressed('-'),
                backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
          ],
        ),
      ],
    );
  }
}
