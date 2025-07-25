import 'package:flutter/material.dart';
import 'package:apka_mgr/games/whack_a_mol/whack_a_mole.dart';

/// Start screen for the Whack-a-Mole game
/// It show the instructions for the game and a button to start the.
class StartScreenWhackAMole extends StatelessWidget {
  const StartScreenWhackAMole({super.key});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    double fontSize1 = screenSize.width * 0.1;
    double fontSize2 = screenSize.width * 0.08;
    double fontSize3 = screenSize.width * 0.05;

    return Scaffold(
      
      backgroundColor: const Color(0xFF71AE8A),
      body: Center(
        child: Container(
        margin: const EdgeInsets.all(10.0),
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
          children: [
            SizedBox(height: screenSize.height * 0.04),
            Text('Uderz w krecika',
              style: TextStyle(fontSize: fontSize1, color: Color(0xFF3D3D3D), fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      'Zasady gry:',
                      style: TextStyle(fontSize: fontSize2, color: const Color(0xFF3D3D3D), fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Text(
                      'Naciśnij na krecika, kiedy wyskoczy z dziury aby zdobyć punkty. '
                      'Każde trafienie to 1 punkt. Nieprawidłowe trafienia są zliczane. \n'
                      'Gra trwa 30 sekund, co sekubdę pojawia się nowy krecik. '
                      ,
                      style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenSize.height * 0.1),
                    Text(
                      'Powodzenia!',
                      style: TextStyle(fontSize: fontSize2, color: const Color(0xFF3D3D3D), fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: screenSize.height * 0.04),
                    WchackAMoleSartButton(),
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
/// It navigates to the game screen 
class WchackAMoleSartButton extends StatelessWidget {
  const WchackAMoleSartButton({super.key});

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
            MaterialPageRoute(builder: (context) => WhackAMoleScreen()),
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