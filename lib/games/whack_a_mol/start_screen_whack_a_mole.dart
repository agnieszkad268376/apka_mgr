import 'package:apka_mgr/patient/choose_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:apka_mgr/games/whack_a_mol/whack_a_mole.dart';

/// Start screen for the Whack-a-Mole game
/// It shows the instructions for the game and a button to start.
/// User can choose game time and mole speed.
class StartScreenWhackAMole extends StatefulWidget {
  const StartScreenWhackAMole({super.key});

  @override
  State<StartScreenWhackAMole> createState() => _StartScreenWhackAMoleState();
}

class _StartScreenWhackAMoleState extends State<StartScreenWhackAMole> {
  // defoult time and speed
  String selectedTime = '60 sekund';
  String selectedSpeed = 'Średni';

  @override
  Widget build(BuildContext context) {
    // screen  and fonts size 
    final screenSize = MediaQuery.of(context).size;
    double fontSize1 = screenSize.width * 0.09;
    double fontSize2 = screenSize.width * 0.08;
    double fontSize3 = screenSize.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFF71AE8A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF71AE8A),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChooseGameScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(
            screenSize.width * 0.1,
            screenSize.width * 0.05,
            screenSize.width * 0.1,
            screenSize.width * 0.1,
          ),
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
            children: [
              Text(
                'Uderz w krecika',
                style: TextStyle(
                  fontSize: fontSize1,
                  color: const Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                child: Text(
                  'Naciśnij na krecika, kiedy wyskoczy z dziury aby zdobyć punkty. '
                  'Uważaj na pojawiające się bomby.\n',
                  style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Czas gry: ',
                      style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D))),
                  SizedBox(width: screenSize.width * 0.02),
                  GameTimeSelection(
                    initialValue: selectedTime,
                    onChanged: (value) {
                      setState(() {
                        selectedTime = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Szybkość krecika: ',
                      style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D))),
                  SizedBox(width: screenSize.width * 0.02),
                  MoleSpeedSelection(
                    initialValue: selectedSpeed,
                    onChanged: (value) {
                      setState(() {
                        selectedSpeed = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.05),
              Text(
                'Powodzenia!',
                style: TextStyle(fontSize: fontSize2, color: const Color(0xFF3D3D3D)),
              ),
              SizedBox(height: screenSize.height * 0.05),
              WchackAMoleSartButton(
                selectedTime: selectedTime,
                selectedSpeed: selectedSpeed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Button to start the Whack-a-Mole game
class WchackAMoleSartButton extends StatelessWidget {
  final String selectedTime;
  final String selectedSpeed;

  const WchackAMoleSartButton({
    super.key,
    required this.selectedTime,
    required this.selectedSpeed,
  });

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
            MaterialPageRoute(
              builder: (context) => WhackAMoleScreen(
                gameTime: selectedTime,
                moleSpeed: selectedSpeed,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF9F97),
          side: const BorderSide(color: Color(0xFFFF9F97), width: 2.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          'Zacznij grę',
          style: TextStyle(fontSize: fontSize, color: const Color(0xFFE7EEFF)),
        ),
      ),
    );
  }
}

/// DropdownMenu to select game time
/// there are three selections: 30, 60, 90 seconds
class GameTimeSelection extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const GameTimeSelection({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      items: <String>['30 sekund', '60 sekund', '90 sekund'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) onChanged(newValue);
      },
    );
  }
}

/// DropdownMenu to select mole speed
/// there are three selections: Slow, Medium, Fast
class MoleSpeedSelection extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const MoleSpeedSelection({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      items: <String>['Powolny', 'Średni', 'Szybki'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) onChanged(newValue);
      },
    );
  }
}
