import 'package:apka_mgr/models/dot_controller_model.dart';
import 'package:apka_mgr/services/database.dart';
import 'package:apka_mgr/services/statistic/dot_controller/dot_controller_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticDotController extends StatefulWidget {
  const StatisticDotController({super.key});

  @override
  State<StatisticDotController> createState() => _StatisticDotControllerState();
}

class _StatisticDotControllerState extends State<StatisticDotController> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    return 
    StreamProvider<List<DotControllerModel>?>.value(
      initialData: null,
      value: DatabaseService(uid: uid).getDotControllerStats(),
      child: Scaffold(
        backgroundColor: Color(0xFF98B6EC),
        body: Center(
          child: DotControllerList(),
        )
      ),
    );
  }
}