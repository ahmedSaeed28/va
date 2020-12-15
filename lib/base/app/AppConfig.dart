import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:va/base/data/AppDatabase.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:va/utilities/Pair.dart';
import 'package:va/utilities/appHelper.dart';
import 'CommonImports.dart';

class AppConfig with ChangeNotifier{

  static final AppConfig shared = AppConfig._internal();
  AppDatabase _database;
  List<Equation> _pendingEquations, _finishedEquations;
  static List<String> operationTypes = ['+', '-', '*', '/'];
  static int _operationType = 0;
  FlutterIsolate _isolate;
  ReceivePort _receivePort;

  AppConfig._internal() {
    _pendingEquations = List();
    _finishedEquations = List();
    _database = AppDatabase();
    _receivePort = ReceivePort();
    _initReceiver();
    _initDatabase();
  }

  void _initDatabase() async{
    await _database.init();
    _database.getEquations().then((value){
      value.forEach((element) {
        if(element.isDone()){
          _finishedEquations.add(element);
        }
        else{
          if(AppHelper.equationIsFinished(DateTime.parse(element.finishingTime))){
            element.done = 1;
            _finishedEquations.add(element);
          } else
            _pendingEquations.add(element);
        }
      });
      _finishedEquations.sort((a, b) =>
          DateTime.parse(a.finishingTime).compareTo(DateTime.parse(b.finishingTime)));
      notifyListeners();
      if(_pendingEquations.isNotEmpty)
        _sendToBackground();
    });
  }

  void _initReceiver(){
    _receivePort.listen((message) {
      Equation equation;
      _pendingEquations.forEach((element) {
        if(element.id.toString() == message)
          equation = element;
      });
      if(equation != null) {
        updateEquation(equation);
        if(_pendingEquations.isEmpty){
          _isolate.kill();
          _isolate = null;
        }
      }
    });
  }

  List<Equation> getPendingEquations(){
    return _pendingEquations;
  }

  List<Equation> getFinishedEquations(){
    return _finishedEquations;
  }
  
  void _sendToBackground() async {
    Map map = Map();
    map['sendPort'] = _receivePort.sendPort;
    map['value'] = AppHelper.encodeListEquations(_pendingEquations);
    if (_isolate != null) {
      _isolate.kill();
    }
    _isolate = await FlutterIsolate.spawn(createBackgroundTask, map);
  }

  void addEquation(Equation equation){
    _database.insertEquation(equation);
    _pendingEquations.add(equation);
    notifyListeners();
    _sendToBackground();
  }

  void updateEquation(Equation equation) async{
    equation.done = 1;
    await _database.updateEquation(equation);
    _pendingEquations.remove(equation);
    _finishedEquations.add(equation);
    notifyListeners();
  }

  void setCurrentOperationType(String type){
    _operationType = operationTypes.indexOf(type);
    notifyListeners();
  }

  int getCurrentOperationType(){
    return _operationType;
  }

  static void createBackgroundTask(Map map){
    List<CustomPair> equations = AppHelper.decodeStringEquations(map['value']);
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      equations.forEach((element) {
        if(AppHelper.equationIsFinished(DateTime.parse(element.time)))
          map['sendPort'].send(element.id);
      });
      equations.removeWhere((item) =>
          AppHelper.equationIsFinished(DateTime.parse(item.time)));
    });
  }
}
