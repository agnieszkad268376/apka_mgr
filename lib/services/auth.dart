import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:apka_mgr/models/appUser.dart';

class AuthService {

  // private instance of FirebaseAuth
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // Create user object based on Firebase User
  AppUser? _userFromFirebaseUser(auth.User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // Auth change user stream
  // When user signs out the login screen is shown
  // When user signs in the home screen is shown 
  Stream<AppUser?> get user {
    return _auth.authStateChanges()
      .map((auth.User? user) => _userFromFirebaseUser(user));
  }

  // Sign in anonymously to app  
  Future<AppUser?> signInAnon() async {
    // if sing in is successful, return user object
    try{
      auth.UserCredential result = await _auth.signInAnonymously();
      auth.User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e){
      // print error message
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  } 

  // Login with email and password
  Future<AppUser?> signInWithEmailAndPassword(String email, String password) async {
    try{
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      auth.User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // Reister with email and password
  Future<AppUser?> registerWithEmailAndPassword(String email, String password) async {
    try{
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      auth.User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}



