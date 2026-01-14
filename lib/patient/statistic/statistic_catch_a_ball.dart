import 'package:apka_mgr/models/catch_a_ball_model.dart';
import 'package:apka_mgr/services/database.dart';
import 'package:apka_mgr/services/statistic/catch_a_ball/catch_a_ball_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticCatchABall extends StatefulWidget {
  const StatisticCatchABall({super.key});

  @override
  State<StatisticCatchABall> createState() => _StatisticCatchABallState();
}

class _StatisticCatchABallState extends State<StatisticCatchABall> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    return 
      StreamProvider<List<CatchABallModel>?>.value( 
        initialData: null,
        value: DatabaseService(uid: uid).getCatchABallStats(),
        child: Scaffold(
          backgroundColor: Color(0xFF98B6EC),
          body: Center(
            child: CatchABallList(),
          )
        ),
      );
  }
}