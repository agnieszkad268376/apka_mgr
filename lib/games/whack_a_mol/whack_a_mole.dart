import 'dart:async';
import 'dart:math';
import 'package:apka_mgr/patient/patient_menu_screen.dart';
import 'package:flutter/material.dart';


/// Whack a mole game screen
class WhackAMoleScreen extends StatefulWidget {
  const WhackAMoleScreen({super.key});

  @override
  State<WhackAMoleScreen> createState() => WhackAMoleScreenState();
}

/// State for the WhackAMoleScreen
/// Game logic
class WhackAMoleScreenState extends State<WhackAMoleScreen> {

  // Number of rows and columns in the grid
  final int rows = 3;
  final int columns = 3;
  // Number of moles to show at a time
  final int moleCount = 10;
  List<bool> moleVisible = [];
  // Default score
  int score = 0;
  int missedHits = 0;
  // Timers for the game
  late Timer gameTimer;
  late Timer moleTimer;
  // Duration of the game in seconds
  int gameDuration = 5;
  int timeLeft = 30;
  bool gameRunning = false;

  // Initialzize game
  @override
  void initState() {
    super.initState();
    starGame();
  }

  /// Starts the game by initializing the mole visibility, score, and timers
  /// Also sets the game running state to true
  /// This method is called when the game starts or restarts
  /// It generates a list of mole visibility states, sets the score to 0,
  void starGame() {
    moleVisible = List.generate(rows * columns, (index) => false);
    score = 0;
    missedHits = 0;
    timeLeft = gameDuration;
    gameRunning = true;

    moleTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!gameRunning || !mounted) return;
        setState(() {
          final random = Random();
          final index = random.nextInt(rows * columns);
          moleVisible[index] = true;
            Timer(Duration(seconds: 1), () {
              if (mounted) {
                setState(() {
                  moleVisible[index] = false;
                });
              }
            });
          } 
        );
    });

    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!gameRunning || !mounted) return;
        setState(() {
          timeLeft--;
          if (timeLeft <= 0){
            gameRunning = false;
            moleTimer.cancel();
            gameTimer.cancel();
            moleVisible = List.generate(rows * columns, (index) => false);

            Future.delayed(Duration.zero, () {
              showDialog(
                barrierColor: Color(0xFFAA4444), // Semi-transparent background
                context: context, 
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  title: const Text('Koniec gry'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Twój wynik: $score'),
                      Text('Pudła: $missedHits'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        starGame(); // Restart the game
                      },
                      child: const Text('Zagraj ponownie'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PatientMenuScreen()));
                      },
                      child: const Text('Wróć do menu'),
                    ),
                  ],
                ),
              );
            });
          }
        });
    });
  }


  /// Handles the tap on a mole
  /// [index] - index of the mole in the grid
  void onTapMole(int index) {
    // If the game is not running or the mole is not visible, do nothing
    if (!gameRunning) return;
    if (moleVisible[index]) {
      setState(() {
        moleVisible[index] = false;
        score++;
      });
    } else {
      setState(() {
        missedHits++; 
      });
    }
  }


  List<Widget> buildGridItems(){
    // Get the screen size to adjust the mole placement
    final screenSize = MediaQuery.of(context).size;
    
    List <Widget> items = [];
    for(int i = 0; i < rows * columns; i++){
      items.add(
        GestureDetector(
          onTap: () => onTapMole(i),
          child: Container(
            margin: const EdgeInsets.all(4.0),
            child: Center(
              child: moleVisible[i] 
                ?  Image.asset('images/mole.png', width: screenSize.width *0.2, height: screenSize.height * 0.33)
                :  Image.asset('images/hole.png', width: screenSize.width *0.2, height: screenSize.height * 0.33)
            ),
          ),
        ),
      );
    }
    return items;
  }


  /// UI for the Whack a Mole game
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xFF49995A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Whack a mole',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          Text(
            'Time left: $timeLeft seconds',
            style: const TextStyle(fontSize: 20, color: Colors.white),
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