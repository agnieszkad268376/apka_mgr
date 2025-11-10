import 'dart:async';
import 'dart:math';
import 'package:apka_mgr/patient/choose_game_screen.dart';
import 'package:flutter/material.dart';

class DotConrollerScreen extends StatefulWidget {
  final String selectedTime;
  final String selectedNumberOfControlledDots;

  const DotConrollerScreen({
    super.key,
    required this.selectedTime,
    required this.selectedNumberOfControlledDots,
  });

  @override
  State<DotConrollerScreen> createState() => _DotConrollerScreenState();
}

class _DotConrollerScreenState extends State<DotConrollerScreen> {
  final Random random = Random();
  final int numberOfDots = 10;
  final double dotSize = 0.05;

  late List<Offset> positions;
  late List<Offset> speeds;
  late List<int> controlledDots; 
  List<int> choosenDots = [];

  int gameDuration = 30;
  late Timer gameTimer;
  

  Timer? _timer;
  bool initialized = false;
  bool isFlying = false;
  bool endGame = false;

  @override
  void initState() {
    super.initState();
    positions = [];
    speeds = [];
    controlledDots = [];

    if (widget.selectedTime == '15 sekund') {
      gameDuration = 15;
    } else if (widget.selectedTime == '30 sekund') {
      gameDuration = 30;
    } else if (widget.selectedTime == '60 sekund') {
      gameDuration = 60;
    }
  }

  void _initDots(Size size, double topBoundary, double bottomBoundary) {
    final double finalDotSize = size.width * dotSize;

    final double xMin = 0;
    final double xMax = size.width - finalDotSize; 
    final double yMin = topBoundary;
    final double yMax = size.height - bottomBoundary - finalDotSize;

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

    int count = int.tryParse(widget.selectedNumberOfControlledDots) ?? 0;
    controlledDots = _pickRandomIndices(numberOfDots, count);

    initialized = true;
  }
  
 
  List<int> _pickRandomIndices(int max, int count) {
    List<int> indices = List.generate(max, (i) => i);
    indices.shuffle(random);
    return indices.take(count).toList();
  }

  // Start moving the dots
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

  void _stopFlying() {
    _timer?.cancel();
    isFlying = false;
  }

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

  void gameResult(){
    endGame = false;

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
      
      Future.delayed(const Duration(milliseconds: 500), () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(isSuccess ? 'Gratulacje!' : 'Twój wynik!'),
            content: Text(
                 'Poprawnie wskazałeś $correctDots z $finalControlledDots kontrolowanych kropek.\n'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseGameScreen()));
                  setState(() {
                  });
                },
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  // TO DO
                  // restart game
                },
                child: const Text('Zagraj ponownie'),
              ),
            ],
          ),
        );
      });
  }

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
