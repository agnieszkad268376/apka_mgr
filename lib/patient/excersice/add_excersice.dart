import 'package:apka_mgr/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Screen for adding an exercise entry.
/// Allows the user to input and save exercise details.
class AddExcerciseScreen extends StatefulWidget {
  const AddExcerciseScreen({super.key});

  @override
  State<AddExcerciseScreen> createState() => AddExcerciseScreenState();
}

/// State for the AddExcerciseScreen widget
class AddExcerciseScreenState extends State<AddExcerciseScreen> {

  // controler for handling exercise input
  final TextEditingController _excerciseController =TextEditingController();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DateTime today = DateTime.now();

  /// Dispose controllers to free resources
  @override
  void dispose() {
    _excerciseController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.08;

    return Scaffold(
      backgroundColor: Color(0xFF98B6EC),
      appBar: AppBar(
        backgroundColor: Color(0xFF98B6EC),
        title: Text('Dodaj ćwiczenie'),
      )
      ,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        
          children: [
            Text('Napisz jakie ćwiczenia dzisiaj wykonałeś',
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 51, 51, 51))),
            SizedBox(height: screenSize.height * 0.05),
            TextField(
              controller: _excerciseController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Wpisz ćwiczenia tutaj',
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: 5,
            ),
            SizedBox(height: screenSize.height * 0.05),
            ElevatedButton(
              onPressed: () async {
                // Tutaj dodaj logikę zapisywania ćwiczenia
                dynamic result = await DatabaseService(uid: uid).addExcersiceData(
                  uid,
                  _excerciseController.text, 
                  today 
                );
                if (result == null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Błąd podczas zapisywania ćwiczenia')),
                  );
                } else {
                  if (context.mounted){
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ćwiczenie zapisane pomyślnie')),
                  );
                  }
                }
              },
              child: Text('Zapisz ćwiczenie',
              style: TextStyle(fontSize: fontSize * 0.6, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}