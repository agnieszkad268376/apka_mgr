import 'package:apka_mgr/models/excercise_model.dart';
import 'package:apka_mgr/models/user_model.dart';
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
  Future updateUserData(String uid, String email, String name, String role, String age, String info) async {
    return await userCollection.doc(uid).set({
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

  // CATCH A BALL GAME DATA
  // Add catch a ball score to Firestore
  Future addCatchABallScore(String uid, DateTime date, int score, int preciseHits, int impreciseHits) async {
    return await _firestore.collection('users').doc(uid).collection('catch_a_ball_scores').add({
      'date': date,
      'score': score,
      'preciseHits': preciseHits,
      'impreciseHits': impreciseHits,
    });
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


  // POINTS DATA
  // Add or update points for a user
  Future updateUserPoints(String uid, int whackAMolePoints, int catchABallPoints, int buildAWordPoints, int reflexCheckPoints, int dotControllerPoints, int points,) async {
    return await _firestore.collection('users').doc(uid).collection('points').doc('pointsDoc').update({
      'whackAMolePoints': FieldValue.increment(whackAMolePoints),
      'catchABallPoints': FieldValue.increment(catchABallPoints),
      'buildAWordPoints': FieldValue.increment(buildAWordPoints),
      'reflexCheckPoints': FieldValue.increment(reflexCheckPoints),
      'dotControllerPoints': FieldValue.increment(dotControllerPoints),
      'points': FieldValue.increment(points),
    });
  }

  // Get points data for a user
  Future<DocumentSnapshot> getUserPoints(String uid) async {
    return await _firestore.collection('users').doc(uid).collection('points').doc('pointsDoc').get();
  }

  // Get all points for user
  Future<int>getAllPoints(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).collection('points').doc('pointsDoc').get();

    if (!doc.exists){
      print('nie działa');
      return 0;
    }

    final data = doc.data() as Map<String, dynamic>;
    print('dalej nie działa');
    return data['points'] ?? 0;
  }
}