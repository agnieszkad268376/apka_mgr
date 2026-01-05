class CatchABallModel {
  final String uid;
  final DateTime date;
  final int score;
  final int preciseHits;
  final int impreciseHits;

  CatchABallModel({
    required this.uid,
    required this.date,
    required this.score,
    required this.preciseHits,
    required this.impreciseHits,
  });
}