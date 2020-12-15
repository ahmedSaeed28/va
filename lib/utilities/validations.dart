class Validations {

  static String validateNumber(String value) {
    if (!_isInteger(value)) return "Number Must be Integer";
    return null;
  }

  static bool _isInteger(String s) {
    if(s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }
}
