import 'package:flutter/material.dart';
import 'package:va/base/app/CommonImports.dart';
import 'package:va/widgets/ButtonWidget.dart';
import 'package:va/widgets/DropDownListWidget.dart';
import 'package:va/widgets/TextFieldWidget.dart';
import 'package:va/widgets/WidgetWithLabel.dart';

class EquationWidget extends StatefulWidget {

  final TextEditingController firstNumberController;
  final TextEditingController secondNumberController;
  final TextEditingController delayController;

  EquationWidget({@required this.firstNumberController,
  @required this.secondNumberController, @required this.delayController});

  @override
  State<StatefulWidget> createState() {
    return _EquationWidgetState();
  }
}
class _EquationWidgetState extends State<EquationWidget>{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              WidgetWithLabel(
                label: firstNumber,
                widget: TextFieldWidget(
                  controller: widget.firstNumberController,
                ),
              ),
              WidgetWithLabel(
                label: operation,
                widget: DropDownListWidget(),
              ),
              WidgetWithLabel(
                label: secondNumber,
                widget:  TextFieldWidget(
                  controller: widget.secondNumberController,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                delayOperation,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: greenColor
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldWidget(
                  controller: widget.delayController,
                ),
              ),
              Text(
                seconds,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: greenColor
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}