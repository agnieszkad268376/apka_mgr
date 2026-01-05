class DotControllerModel {
  String uid;
  DateTime date;
  int score;
  String level;
  String controlledDots;
  String missedDots;

  DotControllerModel({
    required this.uid,
    required this.date,
    required this.score,
    required this.level,
    required this.controlledDots,
    required this.missedDots,
  });
}