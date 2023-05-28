import 'stack.dart';
import 'dart:math' as math;

class Evaluator {
  int precedence(String operator) {
    switch (operator) {
      case '-':
        return 0;
      case '+':
        return 1;
      case '*':
        return 2;
      case '/':
        return 3;
      case '^':
        return 4;
      default:
        return -1;
    }
  }

  double applyOperator(String operator, double operand1, double operand2) {
    switch (operator) {
      case '+':
        return operand1 + operand2;
      case '-':
        return operand1 - operand2;
      case '*':
        return operand1 * operand2;
      case '/':
        return operand1 / operand2;
      case '^':
        return math.pow(operand1, operand2).toDouble();
      default:
        return 0;
    }
  }

  double evaluateExpression(String expression) {
    Stack<double> values = Stack<double>();
    Stack<String> operators = Stack<String>();

    for (int i = 0; i < expression.length; i++) {
      String currentChar = expression[i];

      if (RegExp(r'\d').hasMatch(currentChar) || currentChar == '.') {
        StringBuffer numBuilder = StringBuffer();
        while (i < expression.length &&
            (RegExp(r'\d').hasMatch(expression[i]) || expression[i] == '.')) {
          numBuilder.write(expression[i]);
          i++;
        }
        i--;

        double num = double.parse(numBuilder.toString());
        values.push(num);
      } else if (currentChar == '(') {
        operators.push(currentChar);
      } else if (currentChar == ')') {
        while (operators.isNotEmpty && operators.peek != '(') {
          double operand2 = values.pop();
          double operand1 = values.pop();
          String operator = operators.pop();
          double result = applyOperator(operator, operand1, operand2);
          values.push(result);
        }
        operators.pop(); // Discard the opening parenthesis
      } else if (currentChar == '+' ||
          currentChar == '-' ||
          currentChar == '*' ||
          currentChar == '/' ||
          currentChar == '^') {
        while (operators.isNotEmpty &&
            precedence(operators.peek) >= precedence(currentChar)) {
          double operand2 = values.pop();
          double operand1 = values.pop();
          String operator = operators.pop();
          double result = applyOperator(operator, operand1, operand2);
          values.push(result);
        }
        operators.push(currentChar);
      }
    }

    while (operators.isNotEmpty) {
      double operand2 = values.pop();
      double operand1 = values.pop();
      String operator = operators.pop();
      double result = applyOperator(operator, operand1, operand2);
      values.push(result);
    }

    return values.pop();
  }
}
