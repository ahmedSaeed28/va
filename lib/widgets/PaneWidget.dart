import 'package:flutter/material.dart';
import 'package:va/base/app/CommonImports.dart';

class PaneWidget extends StatefulWidget {

  final String title;
  final Widget list;
  final double width;

  PaneWidget(
      {@required this.title,@required this.list, @required this.width});

  @override
  State<StatefulWidget> createState() {
    return _PaneWidgetState();
  }
}
class _PaneWidgetState extends State<PaneWidget>{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: MediaQuery.of(context).size.height/3,
      decoration: BoxDecoration(
          border: Border.all(color: garyColor,width: 3),
          borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: greenColor,
                decoration: TextDecoration.underline
            ),
          ),
          Expanded(
              child: widget.list
          ),
        ],
      ),
    );
  }

}