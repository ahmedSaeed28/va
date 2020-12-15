import 'package:flutter/material.dart';
import 'package:va/base/app/CommonImports.dart';

class DropDownListWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _DropDownListWidgetState();
  }
}
class _DropDownListWidgetState extends State<DropDownListWidget>{

  String _value;


  @override
  void initState() {
    super.initState();
    _value = AppConfig.operationTypes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DropdownButton<String>(
        items: AppConfig.operationTypes.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
                value,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: greenColor
                ),
            ),
          );
        }).toList(),
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = value;
            AppConfig.shared.setCurrentOperationType(value);
          });
        },
      ),
    );
  }

}