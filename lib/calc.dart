import 'package:calc/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// ignore: must_be_immutable
class Calculator extends StatefulWidget {
  Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "*",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "="
  ];
  var userQuestions = "";
  var userAnswers = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(userQuestions,
                          style: const TextStyle(fontSize: 24))),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswers,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.deepOrange[100],
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, index) {
                    if (index == 0) {
                      // clear button
                      return Buttons(Colors.green, Colors.white, buttons[index],
                          () {
                        setState(() {
                          userQuestions = "";
                        });
                      });
                      //Delete button
                    } else if (index == 1) {
                      return Buttons(Colors.red, Colors.white, buttons[index],
                          () {
                        setState(() {
                          if (userQuestions.length > 0) {
                            userQuestions = userQuestions.substring(
                                0, userQuestions.length - 1);
                          }
                        });
                      });
                    } else if (index == buttons.length - 1) {
                      return Buttons(
                          Colors.deepOrange[50], Colors.white, buttons[index],
                          () {
                        setState(() {
                          equalCalcPressed();
                        });
                      });
                    }
                    return Buttons(
                        isOperator(
                          buttons[index],
                        )
                            ? Colors.deepOrange
                            : Colors.deepOrange[50],
                        isOperator(
                          buttons[index],
                        )
                            ? Colors.white
                            : Colors.deepOrange,
                        buttons[index], () {
                      setState(() {
                        isEmpty();
                        userQuestions += buttons[index];
                      });
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }

  isEmpty() {
    if (userQuestions == "") {
      return userAnswers == "";
    }
  }

  isOperator(x) {
    if (x == "%" || x == "/" || x == "*" || x == "+" || x == "-") {
      return true;
    }
    return false;
  }

  equalCalcPressed() {
    ContextModel cm = ContextModel();
    final finalQuestion = userQuestions;

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswers = eval.toString();
  }
}
