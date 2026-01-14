import 'package:apka_mgr/models/build_a_word_model.dart';
import 'package:apka_mgr/services/database.dart';
import 'package:apka_mgr/services/statistic/build_a_word/build_a_word_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticBuildAWord extends StatefulWidget {
  const StatisticBuildAWord({super.key});

  @override
  State<StatisticBuildAWord> createState() => _StatisticBuildAWordState();
}

class _StatisticBuildAWordState extends State<StatisticBuildAWord> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    return 
    StreamProvider<List<BuildAWordModel>?>.value(
      initialData: null,
      value: DatabaseService(uid: uid).getBuildAWordStats(),
      child: Scaffold(
        backgroundColor: Color(0xFF98B6EC),
        body: Center(
          child: BuildAWordList(),
        )
      ),
    );
  }
} 