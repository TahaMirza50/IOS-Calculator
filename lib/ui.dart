import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cal with ChangeNotifier {
  String _op1 = '0';
  String _op2 = '';
  String _operator = '';
  bool ans = false;

  String get op1 => _op1;

  void set_op1(String value) {
    switch (value) {
      case 'AC':
        {
          _op1 = '0';
          _op2 = '';
          _operator = '';
        }
        break;
      case '+':
        {
          _operator = '+';
          _op2 = _op1;
          _op1 = '0';
        }
        break;
      case '-':
        {
          _operator = '-';
          _op2 = _op1;
          _op1 = '0';
        }
        break;
      case 'x':
        {
          _operator = 'x';
          _op2 = _op1;
          _op1 = '0';
        }
        break;
      case '÷':
        {
          _operator = '÷';
          _op2 = _op1;
          _op1 = '0';
        }
        break;
      case '+/-':
        {
          if (_op1 != '0') {
            _op1 = (double.parse(_op1) * -1).toString();
          }
        }
        break;
      case '=':
        {
          calulate();
          ans = true;
        }
        break;
      case '.':
        {
          if (!op1.contains('.') && !ans) {
            _op1 = '$_op1.';
          } else if (ans) {
            _op1 = '0.';
            ans = false;
          }
        }
        break;
      case '%':
        {
          _op1 = (double.parse(_op1) / 100).toString();
        }
        break;
      default:
        {
          if (ans) {
            _op1 = value;
            ans = false;
          } else {
            if (_op1 == '0' && value == '0') {
              _op1 = '0';
            } else if (_op1 == '0' && value != '0') {
              _op1 = value;
            } else {
              _op1 = '$_op1$value';
            }
          }
        }
        break;
    }
    notifyListeners();
  }

  void calulate() {
    double a = double.parse(_op1);
    double b = double.parse(_op2);
    switch (_operator) {
      case '+':
        {
          a = b + a;
          _op1 = a.toString();
        }
        break;
      case '-':
        {
          a = b - a;
          _op1 = a.toString();
        }
        break;
      case 'x':
        {
          a = b * a;
          _op1 = a.toString();
        }
        break;
      case '÷':
        {
          a = b / a;
          _op1 = a.toString();
        }
        break;
    }
    notifyListeners();
  }
}

class UI extends StatelessWidget {
  const UI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Display(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              button(context, 'AC', Colors.grey.shade400, Colors.black),
              button(context, '+/-', Colors.grey.shade400, Colors.black),
              button(context, '%', Colors.grey.shade400, Colors.black),
              button(context, '÷', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              button(context, '7', Colors.grey.shade800, Colors.white),
              button(context, '8', Colors.grey.shade800, Colors.white),
              button(context, '9', Colors.grey.shade800, Colors.white),
              button(context, 'x', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              button(context, '4', Colors.grey.shade800, Colors.white),
              button(context, '5', Colors.grey.shade800, Colors.white),
              button(context, '6', Colors.grey.shade800, Colors.white),
              button(context, '-', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              button(context, '1', Colors.grey.shade800, Colors.white),
              button(context, '2', Colors.grey.shade800, Colors.white),
              button(context, '3', Colors.grey.shade800, Colors.white),
              button(context, '+', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              button(context, '0', Colors.grey.shade800, Colors.white),
              button(context, '.', Colors.grey.shade800, Colors.white),
              button(context, '=', Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    ));
    // Button(context, '5', Colors.red, Colors.black))
  }

  Widget button(
      BuildContext context, String num, Color colorButton, Color colorText) {
    if (num == '0') {
      return Container(
          clipBehavior: Clip.hardEdge,
          height: 80,
          width: 170,
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: colorButton, // Button color
                foregroundColor: Colors.white,
                padding: const EdgeInsets.only(
                    left: 20, right: 140, top: 20, bottom: 20),
              ),
              child: Text(
                num,
                style: TextStyle(
                    color: colorText,
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () => context.read<Cal>().set_op1('0')));
    }
    return Container(
        clipBehavior: Clip.hardEdge,
        height: 80,
        width: 80,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: colorButton, // Button color
              foregroundColor: Colors.white,
            ),
            child: Text(
              num,
              style: TextStyle(
                  color: colorText, fontSize: 30, fontWeight: FontWeight.w400),
            ),
            onPressed: () => context.read<Cal>().set_op1(num)));
  }
}

class Display extends StatelessWidget {
  const Display({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String display_num = context.watch<Cal>().op1;
    if (display_num.endsWith('.0')) {
      display_num = display_num.substring(0, display_num.length - 2);
    }
    return Align(
      alignment: Alignment.centerRight,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          display_num,
          style: TextStyle(
              color: Theme.of(context).textTheme.headline1!.color,
              fontSize: 100,
              fontWeight: FontWeight.w200),
        ),
      ),
    );
  }
}
