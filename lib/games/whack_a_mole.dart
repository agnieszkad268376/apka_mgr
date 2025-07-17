import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class WhackAMoleScreen extends StatefulWidget {
  const WhackAMoleScreen({super.key});

  @override
  State<WhackAMoleScreen> createState() => _WhackAMoleScreenState();
}

class _WhackAMoleScreenState extends State<WhackAMoleScreen> {

  final int rows = 3;
  final int columns = 3;
  final int moleCount = 10;
  List<bool> moleVisible = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    starGame();
  }


  void starGame() {
    moleVisible = List.generate(rows * columns, (index) => false);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          final random = Random();
          final index = random.nextInt(rows * columns);
          moleVisible[index] = !moleVisible[index];
          if (moleVisible[index]) {
            Timer(Duration(seconds: 1), () {
              if (mounted) {
                setState(() {
                  moleVisible[index] = false;
                });
              }
            });
          } 
        });
      }
    });
  }

  void OnTapMole(int index) {
    if (moleVisible[index]) {
      setState(() {
        moleVisible[index] = false;
        score++;
      });
    }
  }

  List<Widget> buildGridItems(){
    List <Widget> items = [];
    for(int i = 0; i < rows * columns; i++){
      items.add(
        GestureDetector(
          onTap: () => OnTapMole(i),
          child: Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: moleVisible[i] ? Colors.brown : Colors.green,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: moleVisible[i] 
                ? const Icon(Icons.door_front_door_sharp, size: 50, color: Colors.white)
                : const Icon(Icons.grass, size: 50, color: Colors.white),
            ),
          ),
        ),
      );
    }
    return items;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF98B6EC),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Whack a mole',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          const SizedBox(height: 20,),
          GridView.count(
            crossAxisCount: columns,
            shrinkWrap: true,
            children: buildGridItems(),
          ),
        ],
      ),
    );
  }
}