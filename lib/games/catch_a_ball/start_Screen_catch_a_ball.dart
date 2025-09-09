import 'package:apka_mgr/games/catch_a_ball/catch_a_ball.dart';
import 'package:flutter/material.dart';

/// Start screen for the Whack-a-Mole game
/// It show the instructions for the game and a button to start the.
class StartScreenCatchABall extends StatelessWidget {
  const StartScreenCatchABall({super.key});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    double fontSize1 = screenSize.width * 0.1;
    double fontSize2 = screenSize.width * 0.08;
    double fontSize3 = screenSize.width * 0.05;

    return Scaffold(
      
      backgroundColor: const Color(0xFFFFCFCB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFCFCB),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
        margin: EdgeInsets.fromLTRB(screenSize.width*0.1, screenSize.width*0.05, screenSize.width*0.1, screenSize.width*0.1),
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenSize.height * 0.04),
            Text('Złap piłkę',
              style: TextStyle(fontSize: fontSize1, color: Color(0xFF3D3D3D), fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenSize.height * 0.02),
                Column(
                  children: [
                    Text(
                      'Zasady gry:',
                      style: TextStyle(fontSize: fontSize2, color: const Color(0xFF3D3D3D), fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenSize.width*0.02, 0, screenSize.width*0.02, 0),
                      child: 
                      Text(
                      'Na ekranie pojawi się kolejno 10 piłek. Kiedy zobaczysz piłkę kliknij na nią jak najszybciej. '
                      'Gdy złapiesz piłkę, pojawi się kolejna. '
                      'W tej grze liczy się czas, w jakim złapiesz piłki.',
                      style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D)),
                      textAlign: TextAlign.center,
                    )
                    ),
                    SizedBox(height: screenSize.height * 0.05),
                    Text(
                      'Powodzenia!',
                      style: TextStyle(fontSize: fontSize2, color: const Color(0xFF3D3D3D), fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: screenSize.height * 0.04),
                    WchackAMoleStartButton(),
                  ],
                ),
          ],
      ),
        ),
      ),
    );
  }
}

/// Button to start the Whack-a-Mole game
/// It navigates to the game screen and starts the game. 
class WchackAMoleStartButton extends StatelessWidget {
  const WchackAMoleStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.05;
    
    return SizedBox(
      width: screenSize.width * 0.5,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CatchABallScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF9F97),
          side: const BorderSide(color: Color(0xFFFF9F97), width: 2.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text('Zacznij grę', style: TextStyle(fontSize: fontSize, color: Color(0xFFE7EEFF)) ),
      ),
    );
  }
}

