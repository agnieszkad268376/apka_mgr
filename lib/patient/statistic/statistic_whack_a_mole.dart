import 'package:apka_mgr/models/whack_a_mole_model.dart';
import 'package:apka_mgr/services/database.dart';
import 'package:apka_mgr/services/statistic/whack_a_mole/whack_a_mole_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticWhackAMole extends StatefulWidget {
  const StatisticWhackAMole({super.key});

  @override
  State<StatisticWhackAMole> createState() => _StatisticWhackAMoleState();
}

class _StatisticWhackAMoleState extends State<StatisticWhackAMole> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    return 
    StreamProvider<List<WhackAMoleModel>?>.value(
      initialData: null,
      value: DatabaseService(uid: uid).getWhackAMoleStats(),
      child: Scaffold(
        backgroundColor: Color(0xFF98B6EC),
        body: Center(
          child: WhackAMoleList(),
        )
      ),
    );
  }
}