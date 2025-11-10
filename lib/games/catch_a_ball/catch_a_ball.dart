import 'dart:math';
import 'package:apka_mgr/patient/choose_game_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CatchABallScreen extends StatefulWidget {
  final String numberOfBalls;
  final String ballSize;
  const CatchABallScreen({super.key, required this.numberOfBalls, required this.ballSize});

  @override
  State<CatchABallScreen> createState() => CatchABallScreenState();
}

// Poprawić że jak się klika po za popup window to nie gneruje nowej piłki

class CatchABallScreenState extends State<CatchABallScreen> {
  final Random _random = Random();
  late double _ballX = 0;
  late double _ballY = 0;
  double finalBallSize = 0;
  int score = 0;
  int preciseHits = 0;
  int impreciseHits = 0;
  int ballNumber = 1;
  double ballMultiplier = 0;
  int totalBalls = 0;
  bool _hasStarted = false;
  List<Widget> flashes = [];

  /// Resets game settings based on user choices
  /// Sets ball size and total number of balls
  void resetGameSettings() {
    if (widget.ballSize == 'mała') {
      ballMultiplier = 0.20;
    } else if (widget.ballSize == 'średnia') {
      ballMultiplier = 0.30;
    } else if (widget.ballSize == 'duża') {
      ballMultiplier = 0.40;
    } else {
      ballMultiplier = 0.30; 
    }

    if (widget.numberOfBalls == '10') {
      totalBalls = 10;
    } else if (widget.numberOfBalls == '15') {
      totalBalls = 15;
    } else if (widget.numberOfBalls == '20') {
      totalBalls = 20;
    } else {
      totalBalls = 10; 
    }
  }

  /// Initializes the game and schedules the first flash
  @override
  void initState() {
    super.initState();
    resetGameSettings();
    // Start the game after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startGame();
      _scheduleFlash();
    });
  } 

  /// Chcek if dependencies changed
  /// start the game if it hasn't started yet
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      if (!_hasStarted) {
        _hasStarted = true;
        startGame();
        }
    }

  /// Schedules the flashes to appear on random intervals
  /// Works recursively all game 
  void _scheduleFlash() {
  final delay = Duration(milliseconds: 300 + _random.nextInt(1200)); // co 0.3–1.5 sekundy
  Timer(delay, () {
    if (!mounted) return;

    final flashCount = 1 + _random.nextInt(4);

    for (int i = 0; i < flashCount; i++) {
      _addFlash();
    }
    _scheduleFlash();
  });
}

  /// Adds a flash at a random position and removes it
  void _addFlash() {
    final screenSize = MediaQuery.of(context).size;
    final xFlash = _random.nextDouble() * (screenSize.width - 100);
    final yFlash = _random.nextDouble() * (screenSize.height - 100); 

    final flashWidget = Positioned(
      left: xFlash,
      top: yFlash,
      child: const FlashWidget(),
    );

    // Add flash to the list
    // Remove flash after 500 milliseconds
    setState(() {
      flashes.add(flashWidget);
    });

    Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        flashes.remove(flashWidget);
      });
    });
  }

  /// Starts or restarts the game 
  /// Reset settings and initialize genereting ball
  void startGame() {
    resetGameSettings();
    score = 0;
    preciseHits = 0;
    impreciseHits = 0;
    ballNumber = 1;
    _generateBall();
  }

  /// Generates a new ball at a random position
  void _generateBall() {
    final size = MediaQuery.of(context).size;
    finalBallSize = size.width * ballMultiplier;
    setState(() {
      _ballX = _random.nextDouble() * (size.width - finalBallSize);
      _ballY = _random.nextDouble() * (size.height - finalBallSize - 100); // -100 żeby nie wchodziło pod AppBar
    });
  }

  /// Increases the score when the ball is tapped and generate a new ball
  /// [points] - points to add to the score
  void _onBallTap(int points) {
    setState(() {
      score += points;
      ballNumber += 1;
      if (points == 3) {
        preciseHits += 1;
      } else {
        impreciseHits += 1;
      }
      if (ballNumber > totalBalls) {
        // End the game after chosen number of balls
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Koniec gry!'),
            // Display game score and hits 
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Twój wynik to $score punktów.'),
                Text('Celne trafienia: $preciseHits'),
                Text('Niedokładne tradienia: $impreciseHits'),
                ],),         
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  startGame();
                },
                child: Text('Zagraj ponownie', style: TextStyle( color: Color(0xFF98B6EC)),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => ChooseGameScreen()));
                },
                child: Text('Wróć do menu', style: TextStyle(color: Color(0xFF98B6EC)),),
              ),
            ],
          ),
        );
      } else {
        _generateBall();
      }
    });
  }

  /// Builds the game UI
  /// Displays the score and the ball to be tapped
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF4EC),
      appBar: AppBar(
        title: Text("Wynik: $score"),
      ),
      body: Stack(
        children: [
          ...flashes,
          //Ball placement
          Positioned(
            left: _ballX,
            top: _ballY,
            child: SizedBox(
              width: finalBallSize,
              height: finalBallSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Bigest ring
                  GestureDetector(
                    onTap: ()=> _onBallTap(1),
                    child:
                    Container(
                    width: finalBallSize,
                    height: finalBallSize,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(80, 226, 142, 134), 
                    ),
                  ),
                  ),
                  // Medium ring
                  GestureDetector(
                    onTap: ()=> _onBallTap(2),
                    child:
                    Container(
                      width: finalBallSize * 0.7,
                      height: finalBallSize * 0.7,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(150, 226, 142, 134),
                      ),
                    ),
                  ),
                  // Smallest ring
                  GestureDetector(
                    onTap: ()=> _onBallTap(3),
                    child:
                    Container(
                      width: finalBallSize * 0.3,
                      height: finalBallSize * 0.3,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 226, 142, 134),
                      ),
                    ),
                  ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}

/// A widget class for the flash effect
/// Creates a circular shape that later fades out
class FlashWidget extends StatefulWidget {
  const FlashWidget({super.key});

  @override
  State<FlashWidget> createState() => _FlashWidgetState();
}

/// State  for FlashWidget that manages the fade-out animation
class _FlashWidgetState extends State<FlashWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _opacity = Tween<double>(begin: 1, end: 0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF98B6EC),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

