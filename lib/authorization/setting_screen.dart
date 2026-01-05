import 'package:apka_mgr/authorization/password_change.dart';
import 'package:apka_mgr/authorization/users_data_update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apka_mgr/services/database.dart';

/// Ekran logowania do aplikacji
/// Użytkownik może wprowadzić login i hasło, a następnie zalogować się lub zarejestrować. 
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: Color(0xFF98B6EC),
      appBar: AppBar(
        backgroundColor: Color(0xFF98B6EC),
        title: Text('Ustawienia'),
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: DatabaseService(uid: uid).getUserData(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text('No user data found');
            }

            var userData = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: screenSize.height * 0.1),
                    Text('Twoje dane:'),
                  ],
                ),
                Text('Name: ${userData['name']}'),
                Text('Email: ${userData['email']}'),
                Text('Role: ${userData['role']}'),
                Text('Age: ${userData['age']}'),
                Text('Info: ${userData['info']}'),
                
                SizedBox(
                  height: screenSize.height * 0.08,
                  width: screenSize.width * 0.6,
                  child:
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UsersDataUpdateScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDFB4B0),
                        side: const BorderSide(color: Color(0xFFDFB4B0), width: 2.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
                        padding: const EdgeInsets.symmetric(vertical: 10),),
                      child: Row(
                        children: [
                          SizedBox(width: screenSize.width * 0.05),
                          Icon(Icons.edit, size: screenSize.height * 0.05, color: Colors.black,),
                          SizedBox(width: screenSize.width * 0.05),
                          Text('Edytuj dane', style: TextStyle(color: Colors.black),),
                        ],
                      ),
                    )
                ),
                SizedBox(height: screenSize.height * 0.02),
                SizedBox(
                  height: screenSize.height * 0.08,
                  width: screenSize.width * 0.6,
                  child:
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PasswordChangeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDFB4B0),
                        side: const BorderSide(color: Color(0xFFDFB4B0), width: 2.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
                        padding: const EdgeInsets.symmetric(vertical: 10),),
                      child: Row(
                        children: [
                          SizedBox(width: screenSize.width * 0.05),
                          Icon(Icons.lock, size: screenSize.height * 0.05, color: Colors.black,),
                          SizedBox(width: screenSize.width * 0.05),
                          Text('Zmień hasło', style: TextStyle(color: Colors.black),),
                        ],
                      ),
                    )
                ),
              ],
            );
          },
        ),
      )
    );
  }
}

