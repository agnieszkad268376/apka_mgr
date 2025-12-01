import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:apka_mgr/models/appUser.dart';

class AuthService {

  // private instance of FirebaseAuth
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // Create user object based on Firebase User
  AppUser? _userFromFirebaseUser(auth.User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
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

  // TO DO register anonymously
}



