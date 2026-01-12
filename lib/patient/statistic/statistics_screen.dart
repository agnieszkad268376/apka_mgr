import 'package:apka_mgr/patient/statistic/statistic_build_a_word.dart';
import 'package:apka_mgr/patient/statistic/statistic_catch_a_ball.dart';
import 'package:apka_mgr/patient/statistic/statistic_dot_controller.dart';
import 'package:apka_mgr/patient/statistic/statistic_reflex_check.dart';
import 'package:apka_mgr/patient/statistic/statistic_whack_a_mole.dart';
import 'package:flutter/material.dart';

/// Ekran logowania do aplikacji
/// Użytkownik może wprowadzić login i hasło, a następnie zalogować się lub zarejestrować. 
class StatisticsScreen extends StatelessWidget {
  StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return 
    Scaffold(
      backgroundColor: Color(0xFFFFF1E3),
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.1,
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFF98B6EC),
        centerTitle: true,
        title: const Text('Statystyki'),
      ),
    
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFCF4EC),
                fixedSize: Size(screenSize.width * 0.9, screenSize.height * 0.09),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide( 
                    color: Color(0xFFCEC3BA),  
                    width: 2,             
                  ),
                ),
              ),
              onPressed: () {
               Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context)=> const StatisticWhackAMole()
                  ),
                );
              },
              child: const Text('Uderz w krecika', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA49C94)),),
            ),
            SizedBox(height: screenSize.height*0.03),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFCF4EC),
                fixedSize: Size(screenSize.width * 0.9, screenSize.height * 0.09),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide( 
                    color: Color(0xFFCEC3BA),  
                    width: 2,             
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context)=> const StatisticCatchABall()
                  ),
                );
              },
              child: const Text('Złap piłkę', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA49C94)),),
            ),
            SizedBox(height: screenSize.height*0.03),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFCF4EC),
                fixedSize: Size(screenSize.width * 0.9, screenSize.height * 0.09),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide( 
                    color: Color(0xFFCEC3BA),  
                    width: 2,             
                  ),
                ),
              ),
              onPressed: () {
               Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context)=> const StatisticBuildAWord()
                  ),
               );
              },
              child: const Text('Zbuduj słowo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA49C94)),),
            ),
            SizedBox(height: screenSize.height*0.03),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFCF4EC),
                fixedSize: Size(screenSize.width * 0.9, screenSize.height * 0.09),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide( 
                    color: Color(0xFFCEC3BA),  
                    width: 2,             
                  ),
                ),
              ),
              onPressed: () {
               Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context)=> const StatisticReflexCheck()
                  ),
               );
              },
              child: const Text('Sprawdź refleks', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA49C94)),),
            ),
            SizedBox(height: screenSize.height*0.03),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFCF4EC),
                fixedSize: Size(screenSize.width * 0.9, screenSize.height * 0.09),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide( 
                    color: Color(0xFFCEC3BA),  
                    width: 2,             
                  ),
                ),
              ),
              onPressed: () {
               Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context)=> const StatisticDotController()
                  ),
               );
              },
              child: const Text('Śledź kropkę', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA49C94)),),
            ),
          ],
        ),
      ),
    
    );
  }
}

