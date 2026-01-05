class BuildAWordModel {

  final String uid;
  final DateTime date;
  final int score;
  final int missedLetters;
  final String level;

  BuildAWordModel({
    required this.uid, 
    required this.date, 
    required this.score, 
    required this.missedLetters, 
    required this.level});
}