import 'package:apka_mgr/games/dot_controller/start_screen_dot_controller.dart';
import 'package:apka_mgr/games/build_a_word/start_screen_build_a_word.dart';
import 'package:apka_mgr/games/catch_a_ball/start_screen_catch_a_ball.dart';
import 'package:apka_mgr/games/reflex_check/stert_screen_reflex_check.dart';
import 'package:apka_mgr/games/whack_a_mol/start_screen_whack_a_mole.dart';
import 'package:apka_mgr/patient/patient_menu_screen.dart';
import 'package:flutter/material.dart';

/// Patient view menu screen
/// Paietnt can choose witch game he wants to play
/// Patient can go to settings, check statistics or log out.
class ChooseGameScreen extends StatelessWidget {
  const ChooseGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return 
    Scaffold(
      backgroundColor: Color(0xFFFCF4EC),
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.1,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF98B6EC),
        centerTitle: true,
        title: const Text('Menu Pacjenta'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PatientMenuScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: IconButton(
                  icon: Image.asset('images/whack_a_mole.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenWhackAMole()),
                    );
                  },
                ),
                ),
                SizedBox(width: screenSize.width * 0.05),
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: IconButton(
                  icon: Icon(Icons.circle, size: screenSize.width*0.3,),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenCatchABall()),
                    );
                  },
                ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: IconButton(
                  icon: Icon(Icons.abc, size: screenSize.width*0.3,),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenBuildAWord()),
                    );
                  },
                ),
                ),
                SizedBox(width: screenSize.width * 0.05),
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: IconButton(
                  icon: Icon(Icons.lock_clock, size: screenSize.width*0.3,),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenReflexCheck()),
                    );
                  },
                ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: IconButton(
                  icon: Icon(Icons.airlines_outlined, size: screenSize.width*0.3,),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenDotController()),
                    );
                  },
                ),
                ),
                SizedBox(width: screenSize.width * 0.05),
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: RandomGameButton()
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}

/// A button that selects a random game and navigates to its start screen.
class RandomGameButton extends StatelessWidget {
  RandomGameButton({super.key});

  // List of available games
  final List<String> games = [
      'Whack a Mole',
      'Catch a Ball',
      'Build a Word',
      'Reflex Check',
      'Dot Controller',
    ];
  
  // Function to get a random game from the list
  String getRandomGames() {
    games.shuffle();
    return games.first;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (getRandomGames() == 'Whack a Mole') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StartScreenWhackAMole()),
          );
        } else if (getRandomGames() == 'Catch a Ball') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StartScreenCatchABall()),
          );
        } else if (getRandomGames() == 'Build a Word') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StartScreenBuildAWord()),
          );
        } else if (getRandomGames() == 'Reflex Check') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StartScreenReflexCheck()),
          );
        } else if (getRandomGames() == 'Dot Controller') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StartScreenDotController()),
          );
        }
      },
      child: const Text('Losowa Gra'),
    );
  }
}