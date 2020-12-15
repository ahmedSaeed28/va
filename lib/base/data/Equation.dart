import 'package:better_uuid/uuid.dart';
import 'package:va/base/app/CommonImports.dart';
import 'package:va/contstants/DatabaseConstants.dart';


class Equation{
  final int id;
  final int firstNumber;
  final int secondNumber;
  final int operationType;
  final String finishingTime;
  int result;
  int done;

  Equation({this.id, @required this.firstNumber, @required this.secondNumber,
  @required this.operationType, this.result, this.done,
    this.finishingTime});

  Equation.origin(this.firstNumber, this.secondNumber, this.operationType,
      this.finishingTime): this.id=Uuid.v1().time, this.done=0{
    _setResult();
  }

  bool isDone(){
    return done == 1;
  }

  void _setResult(){
    switch (operationType){
      case 0 :
        result = firstNumber + secondNumber;
        break;
      case 1 :
        result = firstNumber - secondNumber;
        break;
      case 2 :
        result = firstNumber * secondNumber;
        break;
      case 3 :
        result = (firstNumber / secondNumber) as int;
        break;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      idCollum : id,
      firstNumberColumn : firstNumber,
      secondNumberColumn : secondNumber,
      operationTypeColumn : operationType,
      finishingTimeColumn : finishingTime,
      resultColumn : result,
      doneColumn : done
    };
  }

  String toString(){
    if(done == 1){
      return firstNumber.toString() + " " +
          AppConfig.operationTypes[operationType] +
          " " + secondNumber.toString() + " = " + result.toString();
    } else {
      return firstNumber.toString() + " " +
          AppConfig.operationTypes[operationType] +
          " " + secondNumber.toString();
    }
  }

  String encode(){
    return id.toString() + "#" +  finishingTime;
  }
}