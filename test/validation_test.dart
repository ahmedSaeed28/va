import 'package:flutter_test/flutter_test.dart';
import 'package:va/base/app/CommonImports.dart';
import 'package:va/utilities/appHelper.dart';
import 'package:va/utilities/validations.dart';

void main() {
  test('When check if equation is executed', () async {
    Equation equation = Equation(
        firstNumber: 1,
        secondNumber: 2,
        operationType: 0,
        finishingTime: DateTime.now().add(Duration(seconds: int.parse("2"))).toString());
    DateTime dateTime = DateTime.parse(equation.finishingTime);
    expect(AppHelper.equationIsFinished(dateTime), false);
  });

  test('When check number is integer', () async {
    String message = Validations.validateNumber("5.2");
    expect(message, "Number Must be Integer");
  });
}