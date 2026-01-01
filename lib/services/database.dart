import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String uid;
  DatabaseService({required this.uid});

  // reference to users collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // create a new document with uid as the document ID
  // update user data
  // this method is used when creating a new user document or updating existing one
  Future updateUserData(String uid, String email, String role, String age, String info) async {
    return await userCollection.doc(uid).set({
      'email': email,
      'role': role,
      'age': age,
      'info': info,
    });
  }

  // Example method to get user data
  //Future<DocumentSnapshot> getUserData(String uid) async {
    //return await _firestore.collection('users').doc(uid).get();
  //}

  // Example method to set user data
  //Future<void> setUserData(String uid, Map<String, dynamic> data) async {
    //await _firestore.collection('users').doc(uid).set(data);
  //}
}