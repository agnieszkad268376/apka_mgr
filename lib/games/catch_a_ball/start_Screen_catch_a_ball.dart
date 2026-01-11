import 'package:apka_mgr/games/catch_a_ball/catch_a_ball.dart';
import 'package:apka_mgr/patient/choose_game_screen.dart';
import 'package:flutter/material.dart';

/// Start screen for the Whack-a-Mole game
/// It show the instructions for the game and a button to start the.
class StartScreenCatchABall extends StatefulWidget {
  const StartScreenCatchABall({super.key});

  @override
  State<StartScreenCatchABall> createState() => _StartScreenCatchABallState();
}

/// State for the StartScreenCatchABall
/// builds IU for the screen and allows to select game options
class _StartScreenCatchABallState extends State<StartScreenCatchABall> {
  /// Number of balls in game (10 by default)
  String selectedNumberOfBalls = '10';
  /// Size of the ball (medium by default)
  String selectedBallSize = 'średnia';

  @override
  Widget build(BuildContext context) {
    // screen size and font sizes
    final screenSize = MediaQuery.of(context).size;
    double fontSize1 = screenSize.width * 0.09;
    double fontSize2 = screenSize.width * 0.08;
    double fontSize3 = screenSize.width * 0.05;
    

    return Scaffold(
      backgroundColor: const Color(0xFFFFCFCB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFCFCB),
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
                      'Na ekranie będą pojawiać się czerwone okręgi. Staraj się kliknąć w środek okręgu '
                      'W tej grze liczy się czas.',
                      style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D)),
                      textAlign: TextAlign.center,
                    )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Liczba piłek: ',
                          style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D)),
                        ),
                        NumeberOfBalls(
                          initialValue: selectedNumberOfBalls,
                          onChanged: (value) {
                            setState((){
                              selectedNumberOfBalls = value;           
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Wielkość piłki: ',
                          style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D)),
                        ),
                        BallSize(
                          initialValue: selectedBallSize,
                          onChanged: (value) {
                            setState((){
                              selectedBallSize = value;           
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.05),
                    Text(
                      'Powodzenia!',
                      style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D), fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: screenSize.height * 0.04),
                    CatchABallButton(
                      selectedNumeberOfBalls: selectedNumberOfBalls,
                      selectedBallSize: selectedBallSize,
                    ),
                  ],
                ),
          ],
      ),
        ),
      ),
    );
  }
}

/// Button to start the Catch-a-Ball game
/// It navigates to the game screen and starts the game. 
class CatchABallButton extends StatelessWidget {
  /// Selected how meny balls will apear in game
  final String selectedNumeberOfBalls;
  /// Defined ball's size
  final String selectedBallSize;

  /// Constructor for CatchABallButton
  const CatchABallButton({super.key, required this.selectedNumeberOfBalls, required this.selectedBallSize});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.04;
    
    return SizedBox(
      width: screenSize.width * 0.5,
      height: screenSize.height * 0.07,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CatchABallScreen(
              numberOfBalls: selectedNumeberOfBalls,
              ballSize: selectedBallSize,
            )),
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

/// Dropdown to select number of balls in the Catch-a-Ball game
/// Allowed values are 10, 15, 20
class NumeberOfBalls extends StatelessWidget {
  /// Initial value of the dropdown
  final String initialValue;
  /// Callback when the value changes
  final ValueChanged<String> onChanged;

  /// Constructor for NumeberOfBalls
  const NumeberOfBalls({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      items: <String>['10', '15', '20'].map((String value) {
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

/// Dropdown to select size of the ball in the Catch-a-Ball game
/// Allowed values are small, medium, large
class BallSize extends StatelessWidget {
  /// Initial value of the dropdown
  final String initialValue;
  /// Callback when the value changes
  final ValueChanged<String> onChanged;

  ///` Constructor for BallSize
  const BallSize({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      items: <String>['mała', 'średnia', 'duża'].map((String value) {
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

