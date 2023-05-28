import 'package:calculator_app/utils.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '';
  double _result = 0;

  void _calculate() {
    setState(() {
      _result = Evaluator().evaluateExpression(_displayText);
      _displayText = _result.toString();
    });
  }

  void _clear() {
    setState(() {
      _displayText = '';
    });
  }

  void _appendCharacter(String character) {
    setState(() {
      _displayText += character;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                alignment: Alignment.bottomRight,
                child: Text(
                  _displayText,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          _buildRow(['(', ')', '^', '-'], _appendCharacter),
          _buildRow(['7', '8', '9', '+'], _appendCharacter),
          _buildRow(['4', '5', '6', '*'], _appendCharacter),
          _buildRow(['1', '2', '3', '/'], _appendCharacter),
          _buildRow(['0', '.', 'AC', '='], _appendCharacter),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> buttons, Function(String) onPressed) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons
            .map((button) => Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {
                        if (button == '=') {
                          _calculate();
                          return;
                        }
                        if (button == 'AC') {
                          _clear();
                          return;
                        }
                        onPressed(button);
                      },
                      child: Text(button),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
