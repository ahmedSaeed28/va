import 'package:flutter/material.dart';
import 'package:va/base/app/CommonImports.dart';

class ButtonWidget extends StatefulWidget {
  ButtonWidget({@required this.text, this.function});

  final String text;
  final Function function;

  @override
  State<StatefulWidget> createState() {
    return _ButtonWidgetState();
  }
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 45, right: 45),
      child: FlatButton(
        shape: OutlineInputBorder(
          borderSide:  BorderSide(
            color: greenColor,
            width: 1,
          ),
          borderRadius:  BorderRadius.all(Radius.circular(4.0)),
        ),
        onPressed: () {
          widget.function();
        },
        color: greenColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.text,
            style: TextStyle(
              color: backgroundColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

  }
}
