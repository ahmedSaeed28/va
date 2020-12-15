import 'package:va/base/data/Equation.dart';
import 'package:va/utilities/Pair.dart';

class AppHelper{

  static bool equationIsFinished(DateTime finishingTime){
    final current = DateTime.now();
    return finishingTime.difference(current).inSeconds <= 0;
  }

  static String encodeListEquations(List<Equation> equations){
    String encoded = "";
    equations.forEach((element) {
      encoded += element.encode();
      encoded += ",";
    });
    return encoded.substring(0, encoded.length-2);
  }

  static List<CustomPair> decodeStringEquations(String text){
    List<CustomPair> equations = List();
    text.split(",").forEach((element) {
      equations.add(CustomPair(element));
    });
    return equations;
  }
}
