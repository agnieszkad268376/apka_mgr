import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ReflexCheckScreen extends StatefulWidget {
  const ReflexCheckScreen({super.key});

  @override
  State<ReflexCheckScreen> createState() => _ReflexCheckScreenState();
}

class _ReflexCheckScreenState extends State<ReflexCheckScreen> {
  Color buttonColor = Colors.red;
  int score = 0;
  int roundsLeft = 5;
  bool gameRunning = false;
  Timer? colorChangeTimer;
  final Random random = Random();

  void startGame() {
    setState(() {
      score = 0;
      roundsLeft = 5;
      gameRunning = true;
      buttonColor = Colors.red;
    });

    _scheduleNextColorChange();
  }

  void _scheduleNextColorChange() {
    if (!gameRunning || roundsLeft == 0) return;


  int delay = random.nextInt(4) + 2; 
  colorChangeTimer = Timer(Duration(seconds: delay), () {
    setState(() {
      buttonColor = Colors.green;
    });
  });
  }


  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Koniec gry!'),
        content: Text('Twój wynik to: $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    colorChangeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double fontSize1 = screenSize.width * 0.09;
    double fontSize2 = screenSize.width * 0.12;
    double fontSize3 = screenSize.width * 0.08;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF4EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF4EC),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Kliknij kolor',
              style: TextStyle(
                fontSize: fontSize2,
                color: const Color(0xFF3D3D3D),
                fontWeight: FontWeight.bold,
              ),
          ),
            SizedBox(height: screenSize.height * 0.02),
            Text(
              gameRunning
                  ? 'Pozostało rund: $roundsLeft'
                  : 'Naciśnij Start, aby zacząć',
              style: TextStyle(
                fontSize: fontSize3,
                color: const Color(0xFF3D3D3D),
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            ElevatedButton(
              onPressed: gameRunning ? null : startGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF98B6EC),
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.1,
                  vertical: screenSize.height * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Start',
                style: TextStyle(fontSize: fontSize2, color: Colors.white),
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            GestureDetector(
              onTap: () {
                if (gameRunning && buttonColor == Colors.green) {
                  setState(() {
                  score++;
                  buttonColor = Colors.red;
                  roundsLeft--;
                  });

                  colorChangeTimer?.cancel();

                if (roundsLeft == 0) {
                  gameRunning = false;
                  _showGameOverDialog();
                  return;
                }
                _scheduleNextColorChange();
                }
              },
              child: Container(
                width: screenSize.width * 0.8,
                height: screenSize.width * 0.8,
                decoration: BoxDecoration(
                  color: buttonColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$score',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
