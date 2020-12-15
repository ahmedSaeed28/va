import 'package:flutter/material.dart';
import 'package:va/base/app/CommonImports.dart';

class WidgetWithLabel extends StatefulWidget {

  final String label;
  final Widget widget;

  WidgetWithLabel({@required this.label, @required this.widget});

  @override
  State<StatefulWidget> createState() {
    return _WidgetWithLabelState();
  }
}
class _WidgetWithLabelState extends State<WidgetWithLabel>{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: greenColor
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: widget.widget,
          ),
        ],
      ),
    );
  }

}