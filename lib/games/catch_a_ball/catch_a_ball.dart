import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CatchABallScreen extends StatefulWidget {
  const CatchABallScreen({super.key});

  @override
  State<CatchABallScreen> createState() => CatchABallScreenState();
}

class CatchABallScreenState extends State<CatchABallScreen> {
  final Random _random = Random();
  late double _ballX;
  late double _ballY;
  double ballSize = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    // Game will start after the first frame is rendered
    // It prevents starting the MediaQuery before the size of a sreen is known
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _spawnBall();
    });
  }

  void _spawnBall() {
    final size = MediaQuery.of(context).size;
    ballSize = size.width * 0.15;
    setState(() {
      _ballX = _random.nextDouble() * (size.width - ballSize);
      _ballY = _random.nextDouble() * (size.height - ballSize - 100); // -100 żeby nie wchodziło pod AppBar
    });
  }

  void _onBallTap() {
    setState(() {
      score++;
    });
    _spawnBall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF4EC),
      body: Stack(
        children: [
          Positioned(
            left: _ballX,
            top: _ballY,
            child: GestureDetector(
              onTap: _onBallTap,
              child: SizedBox(
                width: ballSize,
                height: ballSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Największe, najjaśniejsze koło
                    Container(
                      width: ballSize,
                      height: ballSize,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(80, 226, 142, 134), // półprzezroczyste
                      ),
                    ),
                    // Środkowe
                    Container(
                      width: ballSize * 0.7,
                      height: ballSize * 0.7,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(150, 226, 142, 134),
                      ),
                    ),
                    // Punkt centralny
                    Container(
                      width: ballSize * 0.3,
                      height: ballSize * 0.3,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 226, 142, 134),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
