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
    final fontSize = screenSize.width * 0.07;
    final fontSize1 = screenSize.height * 0.03;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 191, 207, 236),
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.1,
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFF98B6EC),
        title: Text('Dodaj Ćwiczenia', style: TextStyle(fontSize: fontSize1),),
      )
      ,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(
            screenSize.width * 0.1,
            screenSize.width * 0.05,
            screenSize.width * 0.1,
            screenSize.width * 0.1,
          ),
          width: screenSize.width * 0.8,
          height: screenSize.height * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.7),
                spreadRadius: 5,
                blurRadius: 3,
                offset: const Offset(0, 3),
              )
            ]
          ),
          child: Padding(
            padding: EdgeInsets.all(screenSize.width*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            
              children: [
                Text('Zapisz dzisiaj wykonane ćwiczenia wzrokowe',
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
                  maxLines: 15,
                ),
                SizedBox(height: screenSize.height * 0.05),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCEC3BA),
                    side: const BorderSide(color: Color(0xFFCEC3BA), width: 2.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    fixedSize: Size(screenSize.width*0.5, screenSize.height*0.08)
                  ),
                  onPressed: () async {
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
                  child: Text('Zapisz ćwiczenia',
                  style: TextStyle(fontSize: fontSize1, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}