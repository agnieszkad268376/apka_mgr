import 'package:apka_mgr/models/build_a_word_model.dart';
import 'package:apka_mgr/models/catch_a_ball_model.dart';
import 'package:apka_mgr/models/dot_controller_model.dart';
import 'package:apka_mgr/models/excercise_model.dart';
import 'package:apka_mgr/models/reflex_check_model.dart';
import 'package:apka_mgr/models/user_model.dart';
import 'package:apka_mgr/models/whack_a_mole_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String uid;
  DatabaseService({required this.uid});

  // reference to users collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // create a new document with uid as the document ID
  // this method is used when creating a new user document
  Future<void> updateUserData(String uid, String email, String name, String role, String age, String info) async {
    await userCollection.doc(uid).set({
      'email': email,
      'name': name,
      'role': role,
      'age': age,
      'info': info,
    });
  }

  // crreate list from QuerySnapshot
  List<UserModel> _userListFromSnapshot(QuerySnapshot snapshot) {
    // map each document 
    // return empty string if field does not exist
    return snapshot.docs.map((doc){
      return UserModel(
        uid: doc.id,
        email: doc.get('email') ?? '',
        name: doc.get('name') ?? '',
        role: doc.get('role') ?? '',
        age: doc.get('age') ?? '',
        additionalInfo: doc.get('info') ?? '',
      );
    }).toList();
  }

  // return stream of users
  Stream<List<UserModel>> get users {
    return userCollection.snapshots()
    .map(_userListFromSnapshot);
  }

  // Get user data
  Future<DocumentSnapshot> getUserData(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }


  // EXCERSICE DATA

  // Add excersice data to Firestore 
  // Adds a new exercise entry for a user
  Future addExcersiceData(String uid, String excersiceDetails, DateTime date) async {
    return await _firestore.collection('users').doc(uid).collection('exercises').add({
      'details': excersiceDetails,
      'date': date,
    });
  }

  List<ExcerciseModel> _excerciseListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ExcerciseModel(
        uid: doc.id,
        description: doc.get('details') ?? '',
        date: (doc.get('date') as Timestamp).toDate(),
      );
    }).toList();
  }

  Stream<List<ExcerciseModel>> getExcercises() {
    return _firestore.collection('users').doc(uid).collection('exercises').snapshots()
      .map(_excerciseListFromSnapshot);
  }

  // WHACK A MOLE GAME DATA
  // Add whack a mole score to Firestore
  Future addWhackAMoleScore(String uid, int score, DateTime date, String level, String missedHits) async {
    return await _firestore.collection('users').doc(uid).collection('whack_a_mole_scores').add({
      'score': score,
      'date': date,
      'level': level,
      'missedHits': missedHits,
    });
  }

  List<WhackAMoleModel> _statWhackAMoleListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return WhackAMoleModel(
        uid: doc.id,
        date: (doc.get('date') as Timestamp).toDate(),
        score: doc.get('score'),
        missedHits: doc.get('missedHits'),
        level: doc.get('level'),
      );
    }).toList();
  }

  Stream<List<WhackAMoleModel>> getWhackAMoleStats() {
    return _firestore.collection('users').doc(uid).collection('whack_a_mole_scores').snapshots()
      .map(_statWhackAMoleListFromSnapshot);
  }

  // CATCH A BALL GAME DATA
  // Add catch a ball score to Firestore
  Future <void> addCatchABallScore(String uid, DateTime date, int score, int preciseHits, int impreciseHits, int numberOfBalls, int time) async {
    await _firestore.collection('users').doc(uid).collection('catch_a_ball_scores').add({
      'date': date,
      'score': score,
      'preciseHits': preciseHits,
      'impreciseHits': impreciseHits,
      'numberOfBalls': numberOfBalls,
      'time': time 
    });
  }

  List<CatchABallModel> _statCatchABallListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return CatchABallModel(
        uid: doc.id,
        date: (doc.get('date') as Timestamp).toDate(),
        score: doc.get('score'),
        preciseHits: doc.get('preciseHits'),
        impreciseHits: doc.get('impreciseHits'),
        numberOfBalls: doc.get('numberOfBalls'),
        time: doc.get('time')
      );
    }).toList();
  }

  Stream<List<CatchABallModel>> getCatchABallStats() {
    return _firestore.collection('users').doc(uid).collection('catch_a_ball_scores').snapshots()
      .map(_statCatchABallListFromSnapshot);
  }

  // BUILD A WORD GAME DATA
  // Add build a word score to Firestore
  Future addBuildAWordScore(String uid, DateTime date, int score, int missedLetters, String level) async {
    return await _firestore.collection('users').doc(uid).collection('build_a_word_scores').add({
      'date': date,
      'score': score,
      'missedLetters': missedLetters,
      'level': level,
    });
  }

  List<BuildAWordModel> _statBuildAWordSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return BuildAWordModel(
        uid: doc.id,
        date: (doc.get('date') as Timestamp).toDate(),
        score: doc.get('score'),
        missedLetters: doc.get('missedLetters'),
        level: doc.get('level')
      );
    }).toList();
  }

  Stream<List<BuildAWordModel>> getBuildAWordStats() {
    return _firestore.collection('users').doc(uid).collection('build_a_word_scores').snapshots()
      .map(_statBuildAWordSnapshot);
  }


  // REFLEX CHECK GAME DATA
  // Add reflex check data to Firestore
  Future addReflexCheckData(String uid, DateTime date, double averageReactionTime, int roundsPlayed, int score) async {
    return await _firestore.collection('users').doc(uid).collection('reflex_check_scores').add({
      'date': date,
      'averageReactionTime': averageReactionTime,
      'roundsPlayed': roundsPlayed,
      'score': score,
    });
  }

  List<ReflexCheckModel> _statReflexCheckSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return ReflexCheckModel(
        uid: doc.id,
        date: (doc.get('date') as Timestamp).toDate(),
        averageReactionTime: doc.get('averageReactionTime'),
        roundsPlayed: doc.get('roundsPlayed'),
        score: doc.get('score'),
      );
    }).toList();
  }

  Stream<List<ReflexCheckModel>> getReflexCheckStats() {
    return _firestore.collection('users').doc(uid).collection('reflex_check_scores').snapshots()
      .map(_statReflexCheckSnapshot);
  }

  // DOT CONTROLLER GAME DATA
  // Add dot controller data to Firestore
  Future addDotControllerData(String uid, DateTime date, int score, String level, String controlledDots, String missedDots) async {
    return await _firestore.collection('users').doc(uid).collection('dot_controller_scores').add({
      'date': date,
      'score': score,
      'level': level,
      'controlledDots': controlledDots,
      'missedDots': missedDots,
    });
  }

  List<DotControllerModel> _statDotControllerSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return DotControllerModel(
        uid: doc.id,
        date: (doc.get('date') as Timestamp).toDate(),
        score: doc.get('score'),
        level: doc.get('level'),
        controlledDots: doc.get('controlledDots'),
        missedDots: doc.get('missedDots')
      );
    }).toList();
  }

  Stream<List<DotControllerModel>> getDotControllerStats() {
    return _firestore.collection('users').doc(uid).collection('dot_controller_scores').snapshots()
      .map(_statDotControllerSnapshot);
  }


  // POINTS DATA

  Future createUserPoints(String uid) async {
    return await _firestore.collection('users').doc(uid).collection('points').doc('pointsDoc').set({
      'whackAMolePoints': 0,
      'catchABallPoints': 0,
      'buildAWordPoints': 0,
      'reflexCheckPoints': 0,
      'dotControllerPoints': 0,
      'points': 0,
    });
  }

  /// Add or update points for a user
  /// [uid] - user's unique indentificator
  /// [whackAMolePoints] 
  Future<void> updateUserPoints(String uid, int whackAMolePoints, int catchABallPoints, int buildAWordPoints, int reflexCheckPoints, int dotControllerPoints, int points,) async {
    await _firestore.collection('users').doc(uid).collection('points').doc('pointsDoc').set({
      'whackAMolePoints': FieldValue.increment(whackAMolePoints),
      'catchABallPoints': FieldValue.increment(catchABallPoints),
      'buildAWordPoints': FieldValue.increment(buildAWordPoints),
      'reflexCheckPoints': FieldValue.increment(reflexCheckPoints),
      'dotControllerPoints': FieldValue.increment(dotControllerPoints),
      'points': FieldValue.increment(points),
    }, SetOptions(merge: true));
  }

  /// Get points data for a user
  /// [uid] - user's unique indentificator
  Future<DocumentSnapshot> getUserPoints(String uid) async {
    return await _firestore.collection('users').doc(uid).collection('points').doc('pointsDoc').get();
  }

  /// Get all points for user
  /// [uid] - user's unique indentificator
  Future<int>getAllPoints(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).collection('points').doc('pointsDoc').get();

    if (!doc.exists){
      return 0;
    }

    final data = doc.data() as Map<String, dynamic>;
    return data['points'] ?? 0;
  }
}