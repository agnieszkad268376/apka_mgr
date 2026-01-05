import 'package:apka_mgr/models/excercise_model.dart';
import 'package:apka_mgr/services/database.dart';
import 'package:apka_mgr/services/excercise/excercise_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExcerssiceStoryScreen extends StatelessWidget {
  const ExcerssiceStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    return 
    StreamProvider<List<ExcerciseModel>?>.value(
      initialData: null,
      value: DatabaseService(uid: uid).getExcercises(),
      child: Scaffold(
        backgroundColor: Color(0xFF98B6EC),
      
        body: Center(
          child: ExcerciseList(),
        ),
      ),);
  }
}
