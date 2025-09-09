import 'package:flutter/material.dart';
import 'package:apka_mgr/games/whack_a_mol/whack_a_mole.dart';

/// Start screen for the Whack-a-Mole game
/// It show the instructions for the game and a button to start the.
class StartScreenWhackAMole extends StatelessWidget {
  const StartScreenWhackAMole({super.key});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    double fontSize1 = screenSize.width * 0.09;
    double fontSize2 = screenSize.width * 0.08;
    double fontSize3 = screenSize.width * 0.05;
    const List<String> gameTimes = ['30 sekund', '60 sekund', '90 sekund'];
    const List<String> moleSpeeds = ['Powolny', 'Średni', 'Szybki'];

    return Scaffold(
      
      backgroundColor: const Color(0xFF71AE8A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF71AE8A),
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
            Text('Uderz w krecika',
              style: TextStyle(fontSize: fontSize1, color: Color(0xFF3D3D3D), fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenSize.height * 0.02),
                Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.02),
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenSize.width*0.02, 0, screenSize.width*0.02, 0),
                      child: 
                      Text(
                      'Naciśnij na krecika, kiedy wyskoczy z dziury aby zdobyć punkty. '
                      'Uważaj na pojawiające się bomby \n'
                      ,
                      style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D)),
                      textAlign: TextAlign.center,
                    )
                    ),
                    SizedBox(height: screenSize.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Czas gry: ', style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D))),
                        SizedBox(width: screenSize.width * 0.02),
                        // Dropdown for game time selection
                        GameTimeSelection(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Szybkość krecika: ', style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D))),
                        SizedBox(width: screenSize.width * 0.02),
                        // Dropdown for mole speed selection
                        MoleSpeedSelection(),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.05),
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
/// It navigates to the game screen and starts the game. 
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

/// DropdownMenu to select game time
class GameTimeSelection extends StatefulWidget {
  const GameTimeSelection({super.key});

  @override
  State<GameTimeSelection> createState() => _GameTimeSelectionState();
 
}

/// State for the GameTimeSelection widget
/// It manages the selected game time and updates the UI accordingly.
class _GameTimeSelectionState extends State<GameTimeSelection> {
  String selectedTime = '60 sekund';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedTime,
      items: <String>['30 sekund', '60 sekund', '90 sekund'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedTime = newValue!;
        });
      },
    );
  }
}

class MoleSpeedSelection extends StatefulWidget {
  const MoleSpeedSelection({super.key});

  @override
  State<MoleSpeedSelection> createState() => _MoleSpeedSelectionState();
}

class _MoleSpeedSelectionState extends State<MoleSpeedSelection> {
  String selectedSpeed = 'Średni';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedSpeed,
      items: <String>['Powolny', 'Średni', 'Szybki'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedSpeed = newValue!;
        });
      },
    );
  }
}