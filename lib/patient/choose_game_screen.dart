import 'package:apka_mgr/games/build_a_word/start_screen_build_a_word.dart';
import 'package:apka_mgr/games/catch_a_ball/start_Screen_catch_a_ball.dart';
import 'package:apka_mgr/games/whack_a_mol/start_screen_whack_a_mole.dart';
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
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFF98B6EC),
        centerTitle: true,
        title: const Text('Menu Pacjenta'),
        elevation: 0,
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
                  icon: Image.asset('images/whack_a_mole.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenWhackAMole()),
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
                  icon: Image.asset('images/whack_a_mole.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenWhackAMole()),
                    );
                  },
                ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}

