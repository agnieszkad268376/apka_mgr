import 'dart:async';
import 'dart:math';
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

  int gameDuration = 10;
  late Timer gameTimer;
  

  Timer? _timer;
  bool initialized = false;
  bool isFlying = false;

  @override
  void initState() {
    super.initState();
    positions = [];
    speeds = [];
    controlledDots = [];
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
          isFlying = false;
          _stopFlying();
          gameTimer.cancel();
          
          Future.delayed(Duration.zero, () {
            if (mounted) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Time\'s up!'),
                  content: const Text('The flying time is over.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          });
        } 
      });
    });
  }

  void _stopFlying() {
    _timer?.cancel();
    isFlying = false;
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
    final double bottomPadding = padding.bottom + 100;

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
                  child: Container(
                    width: finalDotSize,
                    height: finalDotSize,
                    decoration: BoxDecoration(
                      color: isFlying
                          ? Colors.green 
                          : (controlledDots.contains(i)
                              ? Colors.red 
                              : Colors.grey), 
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Row(
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
              ),
            ],
          ),
    );
  }
}
