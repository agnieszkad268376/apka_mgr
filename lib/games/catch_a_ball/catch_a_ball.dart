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

  @override
  void initState() {
    super.initState();
    resetGameSettings();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startGame();
      _scheduleFlash();
    });
  } 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      if (!_hasStarted) {
        _hasStarted = true;
        startGame();
        }
    }

  void _scheduleFlash() {
    final delay = Duration(milliseconds: 500 + _random.nextInt(2500)); // co 0.5–3 sekundy
    Timer(delay, () {
      if (!mounted) return;
      _addFlash();       
      _scheduleFlash(); 
    });
  }

  void _addFlash() {
    final screenSize = MediaQuery.of(context).size;
    final xFlash = _random.nextDouble() * (screenSize.width - 100);
    final yFlash = _random.nextDouble() * (screenSize.height - 100); 

    final flashWidget = Positioned(
      left: xFlash,
      top: yFlash,
      child: const FlashWidget(),
    );

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

  void startGame() {
    resetGameSettings();
    score = 0;
    preciseHits = 0;
    impreciseHits = 0;
    ballNumber = 1;
    _spawnBall();
  }

  void _spawnBall() {
    final size = MediaQuery.of(context).size;
    finalBallSize = size.width * ballMultiplier;
    setState(() {
      _ballX = _random.nextDouble() * (size.width - finalBallSize);
      _ballY = _random.nextDouble() * (size.height - finalBallSize - 100); // -100 żeby nie wchodziło pod AppBar
    });
  }

  /// Increases the score when the ball is tapped and spawns a new ball
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
          builder: (context) => AlertDialog(
            title: const Text('Koniec gry!'),
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
                        startGame(); // Restart the game
                      },
                      child: Text('Zagraj ponownie', style: TextStyle( color: Color(0xFF98B6EC)),),
                    ),
                    // Button to go back to the patient menu
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseGameScreen()));
                      },
                      child: Text('Wróć do menu', style: TextStyle(color: Color(0xFF98B6EC)),),
                    ),
                  ],
          ),
        );
      } else {
        _spawnBall();
      }
    });
  }

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
                      color: Color.fromARGB(80, 226, 142, 134), // półprzezroczyste
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

class FlashWidget extends StatefulWidget {
  const FlashWidget({super.key});

  @override
  State<FlashWidget> createState() => _FlashWidgetState();
}

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

