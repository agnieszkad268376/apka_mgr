import 'dart:async';
import 'dart:math';
import 'package:apka_mgr/patient/patient_menu_screen.dart';
import 'package:flutter/material.dart';


/// Whack a mole game screen
class WhackAMoleScreen extends StatefulWidget {
  final String gameTime;
  final String moleSpeed;
  const WhackAMoleScreen({super.key, required this.gameTime, required this.moleSpeed});

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
  List<bool> bombVisible = [];
  // Default score
  int score = 0;
  int missedHits = 0;
  // Timers for the game
  late Timer gameTimer;
  late Timer moleTimer;
  late Timer bombTimer;
  // Duration of the game in seconds
  int gameDuration = 0;
  int moleSpeed = 1000; 
  int timeLeft = 30;
  bool gameRunning = false;
  bool _hasStarted = false;

  // Initialzize game
 @override
void initState() {
  super.initState();

  // konwersja czasu gry (string -> sekundy)
  if (widget.gameTime == '30 sekund') {
    gameDuration = 30;
  } else if (widget.gameTime == '60 sekund') {
    gameDuration = 60;
  } else if (widget.gameTime == '90 sekund') {
    gameDuration = 90;
  } else {
    gameDuration = 30; 
  }

  timeLeft = gameDuration;

  // konwersja szybkości krecika (string -> ms)
  if (widget.moleSpeed == 'Powolny') {
    moleSpeed = 1500;
  } else if (widget.moleSpeed == 'Średni') {
    moleSpeed = 1000;
  } else if (widget.moleSpeed == 'Szybki') {
    moleSpeed = 600;
  } else {
    moleSpeed = 1;
  }
}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      if (!_hasStarted) {
        _hasStarted = true;
        starGame();
        }
    }

  /// Starts the game and initializing the mole visibility, score, and timers
  /// Called when the game starts or restarts
  void starGame() {
    moleVisible = List.generate(rows * columns, (index) => false);
    bombVisible = List.generate(rows * columns, (index) => false);
    score = 0;
    missedHits = 0;
    timeLeft = gameDuration;
    gameRunning = true;
    final screenSize = MediaQuery.of(context).size;
    double fontSizeEndGame = screenSize.width * 0.09;
    double fontSizeScore = screenSize.width * 0.06;
    double fontSizeButton = screenSize.width * 0.04;


    // New mole is shown every second
    moleTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // If the game is not running or the widget is not mounted, do nothing
      if (!gameRunning || !mounted) return;
        setState(() {
          // Randolmly select place for mole to show
          final random = Random();
          final index = random.nextInt(rows * columns);
          moleVisible[index] = true;
            // After 1 second the mole is hidden
            Timer(Duration(milliseconds:moleSpeed), () {
              if (mounted) {
                setState(() {
                  moleVisible[index] = false;
                });
              }
            });
          } 
        );
    });

    bombTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (!gameRunning || !mounted) return;
          setState(() {
            final random = Random();
            int index;

    
        do {
          index = random.nextInt(rows * columns);
        } while (moleVisible[index] || bombVisible[index]);

      bombVisible[index] = true;

    
      Timer(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            bombVisible[index] = false;
            missedHits++;
          });
          }
        });
      });
    });

  
    // Countdown timer 
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // If the game is not running or the widget is not mounted, do nothing
      if (!gameRunning || !mounted) return;
        setState(() {
          timeLeft--;
          // If the time is up, the game stops
          // and shows the dialog with the score and missed hits
          if (timeLeft <= 0){
            gameRunning = false;
            moleTimer.cancel();
            gameTimer.cancel();
            moleVisible = List.generate(rows * columns, (index) => false);

            // Show the dialog with the score 
            Future.delayed(Duration.zero, () {
              showDialog(
                context: context, 
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  title: Text('Koniec gry', style: TextStyle(fontSize: fontSizeEndGame),),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Twój wynik: $score', style: TextStyle(fontSize: fontSizeScore),),
                      Text('Pudła: $missedHits', style: TextStyle(fontSize: fontSizeScore),),
                    ],
                  ),
                  backgroundColor:  Color(0xFFE0DAD3),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        starGame(); // Restart the game
                      },
                      child: Text('Zagraj ponownie', style: TextStyle(fontSize: fontSizeButton, color: Color(0xFF98B6EC)),),
                    ),
                    // Button to go back to the patient menu
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PatientMenuScreen()));
                      },
                      child: Text('Wróć do menu', style: TextStyle(fontSize: fontSizeButton, color: Color(0xFF98B6EC)),),
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
    if (!gameRunning) return;

    if (moleVisible[index]) {
      setState(() {
        moleVisible[index] = false;
        score++;
      });
    } else if (bombVisible[index]) {
      setState(() {
        bombVisible[index] = false;
        missedHits++;
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
              child: bombVisible[i]
                ? Image.asset('images/bomb.png', width: screenSize.width * 0.2, height: screenSize.height * 0.33)
                : moleVisible[i]
                  ? Image.asset('images/mole.png', width: screenSize.width * 0.2, height: screenSize.height * 0.33)
                  : Image.asset('images/hole.png', width: screenSize.width * 0.2, height: screenSize.height * 0.33),

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
    final screenSize = MediaQuery.of(context).size;
    double fontSizeTitle = screenSize.width * 0.12;
    double fontSizeTimer = screenSize.width * 0.06;

    return Scaffold(
      backgroundColor: const Color(0xFF71AE8A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Uderz w krecika',
            style: TextStyle(fontSize: fontSizeTitle, color: Colors.white),
          ),
          Text(
            'Pozostały czas: $timeLeft seconds',
            style:  TextStyle(fontSize: fontSizeTimer, color: Colors.white),
          ),
          SizedBox(height: screenSize.height * 0.02),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              'Wynik: $score',
              style: TextStyle(fontSize: fontSizeTimer, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
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