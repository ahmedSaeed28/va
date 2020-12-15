import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:va/base/app/CommonImports.dart';
import 'package:va/utilities/validations.dart';

class TextFieldWidget extends StatefulWidget {

  final TextEditingController controller;

  TextFieldWidget(
      {@required this.controller});

  @override
  State<StatefulWidget> createState() {
    return _TextFieldWidgetState();
  }
}

class _TextFieldWidgetState extends State<TextFieldWidget>{
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: greenColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: greenColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: garyColor,
            ),
          ),
        ),
        style: TextStyle(fontSize: 16, color: greenColor),
        textAlign: TextAlign.center,
        controller: widget.controller,
        validator: (value) {
         return Validations.validateNumber(value);
        },
      ),
    );
  }

}