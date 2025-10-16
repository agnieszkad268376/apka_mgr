import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class AirplaneControllerScreen extends StatefulWidget {
  final String wordLength;
  final String numberOfWords;
  const AirplaneControllerScreen({super.key, required this.wordLength, required this.numberOfWords});

  @override
  State<AirplaneControllerScreen> createState() => _AirplaneControllerScreenState();
}

class _AirplaneControllerScreenState extends State<AirplaneControllerScreen> {
  double top = 100;
  double left = 100;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        top = random.nextDouble() * (MediaQuery.of(context).size.height - 100);
        left = random.nextDouble() * (MediaQuery.of(context).size.width - 100);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            top: top,
            left: left,
            child: Transform.rotate(
              angle: random.nextDouble() * 2 * pi,
              child: Icon(Icons.airplanemode_active, size: 50, color: Colors.white),
            )
          ),
        ],
      ),
    );
  }
}