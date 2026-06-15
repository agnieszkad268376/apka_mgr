import 'package:apka_mgr/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AchivmentsScreen extends StatefulWidget {
  const AchivmentsScreen({super.key});

  @override
  State<AchivmentsScreen> createState() => _AchivmentsScreenState();
}

class _AchivmentsScreenState extends State<AchivmentsScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final screenSize = MediaQuery.of(context).size;
    
    return 
      Scaffold(
        backgroundColor: Color(0xFFE8DBCE),
        appBar: AppBar(
          toolbarHeight: screenSize.height * 0.1,
          backgroundColor: const Color(0xFF98B6EC),
          centerTitle: true,
          title: Text(
            'Osiągnięcia',
            style: TextStyle(fontSize: screenSize.height * 0.035),
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: DatabaseService(uid: uid).getPointsTwo(uid), 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } 
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              var pointsData = snapshot.data?.data() as Map<String, dynamic>?;
              final allPoints = pointsData?['points'] ?? 0;
              final whackAMolePoints = pointsData?['whackAMolePoints'] ?? 0;
              final catchABallPoints = pointsData?['catchABallPoints'] ?? 0;
              final buildAWordPoints = pointsData?['buildAWordPoints'] ?? 0;
              final reflexCheckPoints = pointsData?['reflexCheckPoints'] ?? 0;  
              final dotControllerPoints = pointsData?['dotControllerPoints'] ?? 0;

              List<Map<String, dynamic>> achievements = [
                {
                  'title': 'Zdobądź 1000 punktów',
                  'unlocked': allPoints >= 1000,
                },
                {
                  'title': 'Zdobądź 5000 punktów',
                  'unlocked': allPoints >= 5000,
                },
                {
                  'title': 'Zdobądź 500 punktów w "Uderz w krecika"',
                  'unlocked': whackAMolePoints >= 500,
                },
                {
                  'title': 'Zdobądź 1000 punktów w "Uderz w krecika"',
                  'unlocked': whackAMolePoints >= 1000,
                },
                {
                  'title': 'Zdobądź 500 punktów w "Złap piłkę"',
                  'unlocked': catchABallPoints >= 500,
                },
                {
                  'title': 'Zdobądź 1000 punktów w "Złap piłkę"',
                  'unlocked': catchABallPoints >= 1000,
                },
                {
                  'title': 'Zdobądź 500 punktów w "Zbuduj słowo"',
                  'unlocked': buildAWordPoints >= 500,
                },
                {
                  'title': 'Zdobądź 1000 punktów w "Zbuduj słowo"',
                  'unlocked': buildAWordPoints >= 1000,
                },
                {
                  'title': 'Zdobądź 500 punktów w "Sprawdź refleks"',
                  'unlocked': reflexCheckPoints >= 500,
                },
                {
                  'title': 'Zdobądź 1000 punktów w "Sprawdź refleks"',
                  'unlocked': reflexCheckPoints >= 1000,
                },
                {
                  'title': 'Zdobądź 500 punktów w "Śledź krokę"',
                  'unlocked': dotControllerPoints >= 500,
                },
                {
                  'title': 'Zdobądź 1000 punktów w "Śledź krokę"',
                  'unlocked': dotControllerPoints >= 1000,
                },
              ];

              return Column(
                children: [ 
                  SizedBox(height: screenSize.height * 0.02),
                  Container(
                  height: screenSize.height * 0.38,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Suma punktów: $allPoints', style: TextStyle(fontSize: screenSize.height * 0.025, fontWeight: FontWeight.bold),),
                        Text('Uderz w krecika: $whackAMolePoints', style: TextStyle(fontSize: screenSize.height * 0.025),),
                        Text('Złap piłkę: $catchABallPoints', style: TextStyle(fontSize: screenSize.height * 0.025),),
                        Text('Zbuduj słowo: $buildAWordPoints', style: TextStyle(fontSize: screenSize.height * 0.025),),
                        Text('Sprawdź refleks: $reflexCheckPoints', style: TextStyle(fontSize: screenSize.height * 0.025),),
                        Text('Śledź krokę: $dotControllerPoints', style: TextStyle(fontSize: screenSize.height * 0.025),),
                        
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                Container(
                  height: screenSize.height * 0.38,
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
                      children: [
                        Expanded(
                          child: ListView(
                            children: achievements.map((achievement) {
                              final unlocked = achievement['unlocked'];

                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      unlocked ? Icons.check_circle : Icons.lock,
                                      color: unlocked ? Colors.green : Colors.grey,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        achievement['title'],
                                        style: TextStyle(
                                          fontSize: screenSize.height * 0.022,
                                          color: unlocked ? Colors.black : Colors.grey,
                                          fontWeight: unlocked ? FontWeight.bold : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]
            );
          }
        ),
      )
    );
  }
} 

