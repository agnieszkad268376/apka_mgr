import 'package:apka_mgr/models/reflex_check_model.dart';
import 'package:apka_mgr/services/database.dart';
import 'package:apka_mgr/services/statistic/reflex_check/reflex_check_list_dart.dart';
import 'package:apka_mgr/services/statistic/whack_a_mole/whack_a_mole_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticReflexCheck extends StatefulWidget {
  const StatisticReflexCheck({super.key});

  @override
  State<StatisticReflexCheck> createState() => _StatisticReflexCheckState();
}

class _StatisticReflexCheckState extends State<StatisticReflexCheck> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    return 
    StreamProvider<List<ReflexCheckModel>?>.value(
      initialData: null,
      value: DatabaseService(uid: uid).getReflexCheckStats(),
      child: Scaffold(
        backgroundColor: Color(0xFF98B6EC),
        body: Center(
          child: ReflexCheckListDart(),
        )
      ),);
  }
}