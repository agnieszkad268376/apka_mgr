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
    double fontSize1 = screenSize.height * 0.04;
    double fontSize2 = screenSize.height * 0.03;

    return Scaffold(
      backgroundColor: Color(0xFFE8DBCE),
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.1,
        backgroundColor: const Color(0xFF98B6EC),
        centerTitle: true,
        title: Text(
          'Ustawienia',
          style: TextStyle(fontSize: screenSize.height * 0.035),
        ),
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
            return Container(
              height: screenSize.height * 0.8,
                      width: screenSize.width * 0.9,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF3ED),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.3),
                            spreadRadius: 5,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
              child: Padding(
                padding: EdgeInsets.all(screenSize.height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Twoje dane:', style: TextStyle(fontSize: fontSize1, fontWeight: FontWeight.bold),),
                    SizedBox(height: screenSize.height * 0.03),
                    Row(
                      children: [
                        Icon(Icons.person, size: screenSize.height * 0.08),
                        SizedBox(width: screenSize.width * 0.02),
                        Text('${userData['name']}', style: TextStyle(fontSize: fontSize2),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.email, size: screenSize.height * 0.08),
                        SizedBox(width: screenSize.width * 0.02),
                        Text('${userData['email']}', style: TextStyle(fontSize: fontSize2),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.badge, size: screenSize.height * 0.08),
                        SizedBox(width: screenSize.width * 0.02),
                        Text('${userData['role']}', style: TextStyle(fontSize: fontSize2),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.cake, size: screenSize.height * 0.08),
                        SizedBox(width: screenSize.width * 0.02),
                        Text('${userData['age']}', style: TextStyle(fontSize: fontSize2),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.info, size: screenSize.height * 0.08),
                        SizedBox(width: screenSize.width * 0.02),
                        Text('${userData['info']}', style: TextStyle(fontSize: fontSize2),),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.05),
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
                ),
              ),
            );
          },
        ),
      )
    );
  }
}

