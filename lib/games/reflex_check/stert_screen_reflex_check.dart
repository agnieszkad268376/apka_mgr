import 'package:apka_mgr/games/reflex_check/reflex_check.dart';
import 'package:apka_mgr/patient/choose_game_screen.dart';
import 'package:flutter/material.dart';

/// Start screen for the Whack-a-Mole game
/// It shows the instructions for the game and a button to start.
class StartScreenReflexCheck extends StatefulWidget {
  const StartScreenReflexCheck({super.key});

  @override
  State<StartScreenReflexCheck> createState() => _StartScreenReflexCheckState();
}

class _StartScreenReflexCheckState extends State<StartScreenReflexCheck> {
  String numberOfRounds = '5';
  

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double fontSize1 = screenSize.width * 0.09;
    double fontSize2 = screenSize.width * 0.08;
    double fontSize3 = screenSize.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF4EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF4EC),
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
                'Sprawdź refleks',
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
                  'Na ekranie pojawi się czerwony przycisk. W losowym momencie zmieni on kolor na zielony - jak najszybciej go naciśnij!\n'
                  'Na końcu zobaczysz swój średni czas reakcji.',
                  style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Libcza rund: ',
                      style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D))),
                  SizedBox(width: screenSize.width * 0.02),
                  NumberOfRounds(
                    initialValue: numberOfRounds,
                    onChanged: (value) {
                      setState(() {
                        numberOfRounds = value;
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
              ReflexCheckStartButton(
                numberOfRounds: numberOfRounds,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Button to start the Whack-a-Mole game
class ReflexCheckStartButton extends StatelessWidget {
  final String numberOfRounds;

  const ReflexCheckStartButton({
    super.key,
    required this.numberOfRounds,
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
              builder: (context) => ReflexCheckScreen(
                numberOfRounds: numberOfRounds,
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
class NumberOfRounds extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const NumberOfRounds({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      items: <String>['3', '5', '7'].map((String value) {
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
