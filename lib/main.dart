import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String output = '';

  void handleButtonPress(String value) {
    setState(() {
      if (value == 'C') {
        // Clear input and output
        input = '';
        output = '';
      } else if (value == '=') {
        // Evaluate the expression
        try {
          Parser parser = Parser();
          Expression expression = parser.parse(input);
          ContextModel contextModel = ContextModel();
          double result = expression.evaluate(EvaluationType.REAL, contextModel);
          output = result.toString();
        } catch (e) {
          output = 'Error';
        }
      } else {
        // Append the button value to the input
        input += value;
      }
    });
  }

  Widget buildButton(String text, {Color color = Colors.transparent}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => handleButtonPress(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(20),
          shape: CircleBorder(),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Display Input
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              input,
              style: const TextStyle(fontSize: 32, color: Colors.black87),
            ),
          ),
          // Display Output
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              output,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
          // Buttons Grid
          Expanded(
            child: Column(
              children: [
                Row(children: [buildButton('C', color: Colors.red), buildButton('()'), buildButton('%'), buildButton('/', color: Colors.purpleAccent)]),
                Row(children: [buildButton('7'), buildButton('8'), buildButton('9'), buildButton('x', color: Colors.purpleAccent)]),
                Row(children: [buildButton('4'), buildButton('5'), buildButton('6'), buildButton('_', color: Colors.purpleAccent)]),
                Row(children: [buildButton('1'), buildButton('2'), buildButton('3'), buildButton('+', color: Colors.purpleAccent)]),
                Row(children: [buildButton('+/-'), buildButton('0'), buildButton('.'), buildButton('=', color: Colors.green) ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


