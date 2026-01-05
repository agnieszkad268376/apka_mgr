import 'dart:async';
import 'dart:math';
import 'package:apka_mgr/patient/choose_game_screen.dart';
import 'package:apka_mgr/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Main game screen for Dot Controller game.
class DotConrollerScreen extends StatefulWidget {
  /// Game time previously selected by user
  final String selectedTime;
  /// Number of controlled dots previously selected by user
  final String selectedNumberOfControlledDots;

  /// Constructor for DotConrollerScreen
  /// [selectedTime] - game time selected by user
  /// [selectedNumberOfControlledDots] - number of controlled dots selected by user
  const DotConrollerScreen({
    super.key,
    required this.selectedTime,
    required this.selectedNumberOfControlledDots,
  });

  @override
  State<DotConrollerScreen> createState() => _DotConrollerScreenState();
}

/// State class for DotConrollerScreen
class _DotConrollerScreenState extends State<DotConrollerScreen> {
  // User's uid
  String uid = FirebaseAuth.instance.currentUser!.uid;

  // Random number generator
  final Random random = Random();
  // Total number of dots in the game
  final int numberOfDots = 10;
  // Size of each dot as a fraction of screen width
  final double dotSize = 0.05;

  // Positions of the dots
  late List<Offset> positions;
  // Speeds of the dots
  late List<Offset> speeds;
  // Indexes of controlled dots
  late List<int> controlledDots; 
  // Indexes of dots chosen by player at the end of the game
  List<int> choosenDots = [];

  // Game duration in seconds
  int gameDuration = 30;
  late Timer gameTimer;
  
  // timer and initialization flag
  Timer? _timer;
  bool initialized = false;
  bool isFlying = false;
  bool endGame = false;
  String level = 'easy';

  /// Initialize game state
  @override
  void initState() {
    super.initState();
    positions = [];
    speeds = [];
    controlledDots = [];

    // convert selected time to integer in seconds
    if (widget.selectedTime == '15 sekund') {
      gameDuration = 15;
      level = 'easy';
    } else if (widget.selectedTime == '30 sekund') {
      gameDuration = 30;
      level = 'medium';
    } else if (widget.selectedTime == '60 sekund') {
      gameDuration = 60;
      level = 'hard';
    }
  }

  /// Initialize dots positions and speeds
  void _initDots(Size size, double topBoundary, double bottomBoundary) {
    final double finalDotSize = size.width * dotSize;

    // screen boundaries for dot movement
    final double xMin = 0;
    final double xMax = size.width - finalDotSize; 
    final double yMin = topBoundary;
    final double yMax = size.height - bottomBoundary - finalDotSize;

    // generate random positions and speeds for dots
    positions = List.generate(
      numberOfDots,
      (_) => Offset(
        random.nextDouble() * (xMax - xMin) + xMin,
        random.nextDouble() * (yMax - yMin) + yMin,
      ),
    );

    speeds = List.generate(
      numberOfDots,
      (_) {
        final angle = random.nextDouble() * 2 * pi;
        final speed = 1 * 2;
        return Offset(cos(angle) * speed, sin(angle) * speed);
      },
    );

    // choose controlled dots based on user selection
    int count = int.tryParse(widget.selectedNumberOfControlledDots) ?? 0;
    controlledDots = _pickRandomIndices(numberOfDots, count);

    initialized = true;
  }
  
  /// Pick random unique indices for controlled dots
  List<int> _pickRandomIndices(int max, int count) {
    List<int> indices = List.generate(max, (i) => i);
    indices.shuffle(random);
    return indices.take(count).toList();
  }

  /// Start moving the dots
  void _startFlying(Size size, double topBoundary, double bottomBoundary) {
    if (isFlying) return;
    isFlying = true;
    endGame = false;
    choosenDots.clear();

    final double finalDotSize = size.width * dotSize;
    final double xMin = 0;
    final double xMax = size.width - finalDotSize; 
    final double yMin = topBoundary;
    final double yMax = size.height - bottomBoundary - finalDotSize;

    // Timer that updates dot positions
    // it runs every 35 milliseconds
    _timer = Timer.periodic(const Duration(milliseconds: 35), (timer) {
      setState(() {
        for (int i = 0; i < numberOfDots; i++) {
          double newX = positions[i].dx + speeds[i].dx;
          double newY = positions[i].dy + speeds[i].dy;

          if (newX < xMin || newX > xMax) {
            speeds[i] = Offset(-speeds[i].dx, speeds[i].dy);
          }
          if (newY < yMin || newY > yMax) {
            speeds[i] = Offset(speeds[i].dx, -speeds[i].dy);
          }

          positions[i] = Offset(
            newX,
            newY
          );
        }
      });
    });

    // Timer for game duration countdown
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isFlying || !mounted) return;
      setState(() {
        gameDuration--;
        if (gameDuration <= 0) {
          _stopFlying();
          isFlying = false;
          gameTimer.cancel();
          
          setState(() {
            endGame = true;
          });
          
        } 
      });
    });
  }

  /// Stop moving the dots
  /// Called when time is up or user presses stop
  /// stops the timers and sets isFlying to false
  void _stopFlying() {
    _timer?.cancel();
    isFlying = false;
  }

  /// Handle dot tap by user at the end of the game
  /// [index] - index of tapped dot
  void onDotTapped(int index) {
    if (!endGame) return;

    setState(() {
      if (choosenDots.contains(index)) {
        choosenDots.remove(index);
      } else {
        choosenDots.add(index);
      } 
    });

    if (choosenDots.length == controlledDots.length) {
      gameResult();
    }
  }

  /// Show game result
  void gameResult(){
    endGame = false;

    int score = 0;
    // sets with dots indexes for comparison
    // dots choosen by player
    final choosenSet = Set.from(choosenDots);
    // randomly chosen controlled dots
    final controlledSet = Set.from(controlledDots);

    // choose indexes that are in both sets 
    final correctDots = choosenSet.intersection(controlledSet).length;
    final finalControlledDots = controlledSet.length;

    // check if player selected all controlled dots correctly
    final isSuccess = correctDots == finalControlledDots && choosenSet.length == finalControlledDots;
    int missedDots = finalControlledDots - correctDots;
    score = correctDots*2-missedDots;  

      Future.delayed(const Duration(milliseconds: 500), () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(isSuccess ? 'Gratulacje!' : 'Twój wynik!'),
            content: Text(
                 'Poprawnie wskazałeś $correctDots z $finalControlledDots kontrolowanych kropek.\n Zdobyte punkty: $score'),
            actions: [
              TextButton(
                onPressed: () async {
                  dynamic result = await DatabaseService(uid:uid).addDotControllerData(
                    uid,
                    DateTime.now(),
                    score,
                    level,
                    widget.selectedNumberOfControlledDots,
                    missedDots.toString(),
                  );
                  if (result == null) {
                    if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Błąd podczas zapisywania wyniku gry')),
                    );
                    }
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseGameScreen()));
                  setState(() {
                  });
                },
                child: const Text('Wróć do menu'),
              ),
              TextButton(
                onPressed: () async {
                  dynamic result = await DatabaseService(uid:uid).addDotControllerData(
                    uid,
                    DateTime.now(),
                    score,
                    level,
                    widget.selectedNumberOfControlledDots,
                    missedDots.toString(),
                  );
                  if (result == null) {
                    if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Błąd podczas zapisywania wyniku gry')),
                    );
                    }
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DotConrollerScreen(
                    selectedTime: widget.selectedTime,
                    selectedNumberOfControlledDots: widget.selectedNumberOfControlledDots,
                  )));
                },
                child: const Text('Zagraj ponownie'),
              ),
            ],
          ),
        );
      });
  }

  /// Dispose timers when widget is removed
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    final double topPadding = padding.top + 10;
    final double bottomPadding = padding.bottom + 120;

    final double finalDotSize = screenSize.width * dotSize;
    final double fontSize = screenSize.width * 0.04;

    if (!initialized) {
      _initDots(screenSize, topPadding, bottomPadding);
    }
    
    return Scaffold(
      backgroundColor: Colors.black,
      body:
           Stack(
            children: [
              for (int i = 0; i < numberOfDots; i++)
                Positioned(
                  left: positions[i].dx,
                  top: positions[i].dy,
                  child: 
                  GestureDetector(
                    onTap: () => onDotTapped(i),
                    child:Container(
                    width: finalDotSize,
                    height: finalDotSize,
                    decoration: BoxDecoration(
                      color: isFlying
                          ? Colors.green 
                          : endGame && choosenDots.contains(i)
                            ? Colors.blueAccent
                            : (endGame
                              ? Colors.grey
                              : (controlledDots.contains(i)
                                  ? Colors.green 
                                  : Colors.red)),
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              ),
              Positioned(
                bottom: screenSize.height * 0.03,
                left: 0,
                right: 0,
                child: 
                Column(
                  children: [
                    Text(
                      'Pozostały czas: $gameDuration sekund',
                      style: TextStyle(fontSize: fontSize, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    SizedBox(
                      width: screenSize.width * 0.25,
                      child:
                      ElevatedButton(
                      onPressed: () => _startFlying(screenSize, topPadding, bottomPadding),
                      style: ElevatedButton.styleFrom(
                        
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Start', style: TextStyle(fontSize: fontSize)),
                    ),),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: screenSize.width * 0.25,
                      child: ElevatedButton(
                      onPressed: _stopFlying,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Stop', style: TextStyle(fontSize: fontSize)),
                    ),
                    ),
                    
                  ],
                ),
                  ]),

                
              ),
            ],
          ),
    );
  }
}
