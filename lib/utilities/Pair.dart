class CustomPair{

  String id;
  String time;

  CustomPair(String text){
    List<String> list = text.split("#");
    this.id = list[0];
    this.time = list[1];
  }

}