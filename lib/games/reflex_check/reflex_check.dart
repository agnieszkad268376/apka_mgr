import 'dart:async';
import 'dart:math';
import 'package:apka_mgr/games/reflex_check/stert_screen_reflex_check.dart';
import 'package:apka_mgr/patient/choose_game_screen.dart';
import 'package:apka_mgr/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Screen for the Reflex Check game.
class ReflexCheckScreen extends StatefulWidget {
  /// Number of rounds to play that user selected
  final String numberOfRounds;

  /// Constructor for ReflexCheckScreen
  /// [numberOfRounds] - number of rounds, slected by user
  const ReflexCheckScreen({
    super.key,
    required this.numberOfRounds});

  @override
  State<ReflexCheckScreen> createState() => _ReflexCheckScreenState();
}

/// State for the ReflexCheckScreen widget    
class _ReflexCheckScreenState extends State<ReflexCheckScreen> {
  // User ID
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Color buttonColor = Colors.red;
  // Start score and rouds left
  int score = 0;
  int roundsLeft = 5;
  // Game running flag
  bool gameRunning = false;
  Timer? colorChangeTimer;
  // Random generator
  // to generate time delays
  final Random random = Random();
  DateTime? greenStartTime;
  int? reactionTime;
  List<int> reactionTimes = [];

  // Get user points from database
  late Map<String, dynamic> userPointsMap = {};

  /// Initialize state
  @override
  void initState() {
    super.initState();

    // Initialize userPointsMap from the database
  DatabaseService(uid: uid).getUserData(uid).then((snapshot) {
    if (snapshot.exists) {
      setState(() {
        userPointsMap = snapshot.data() as Map<String, dynamic>;
      });
    }
  });
  }

  /// Start the game
  /// restart game settings
  void startGame() {
    setState(() {
      score = 0;
      gameRunning = true;
      buttonColor = Colors.red;
      reactionTimes.clear();
      reactionTime = null;
      roundsLeft = int.parse(widget.numberOfRounds);
    });

    _scheduleNextColorChange();
  }

  /// Schedule the next color change
  void _scheduleNextColorChange() {
    if (!gameRunning || roundsLeft == 0) return;

  int delay = random.nextInt(4) + 2; 
  colorChangeTimer = Timer(Duration(seconds: delay), () {
    if (!mounted) return;
    setState(() {
      buttonColor = Colors.green;
      greenStartTime = DateTime.now();
      reactionTime = null;
    });
  });
  }

  /// Show dialog when the game is over
  void _showGameOverDialog() {
    // Calculate average reaction time
    double averageReactionTime = reactionTimes.isNotEmpty
        ? reactionTimes.reduce((a, b) => a + b) / reactionTimes.length
        : 0;  

    double roundedAvgReactionTime = (averageReactionTime * 100).round() / 100;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Koniec gry!'),
        content: Text('Twój średni czas reakcji: ${roundedAvgReactionTime.toStringAsFixed(2)} ms \n'
            'Za grę otrzymujesz: $score punktów!'),
        actions: [
          TextButton(
            onPressed: () async {
              dynamic result = await DatabaseService(uid: uid).addReflexCheckData(
                uid,
                DateTime.now(),
                roundedAvgReactionTime,
                int.parse(widget.numberOfRounds),
                score,
              );
              if (result == null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Błąd podczas zapisywania wyniku')),
                );
              }
              try{
                await DatabaseService(uid: uid).updateUserPoints(
                  uid, 
                  0,
                  0,
                  0,
                  score,
                  0,
                  score,
                );
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Błąd podczas aktualizacji punktów')),
                  );
                }
              }
              if (context.mounted){
                Navigator.push(context, MaterialPageRoute(builder: (context) => StartScreenReflexCheck()));
              }
            },
            child: const Text('Zagraj ponownie'),
          ),
          TextButton(
            onPressed: () async {
              dynamic result = await DatabaseService(uid: uid).addReflexCheckData(
                uid, 
                DateTime.now(), 
                roundedAvgReactionTime, 
                int.parse(widget.numberOfRounds), 
                score);

              if (result == null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Błąd podczas zapisywania wyniku')),
                );
              }
              try{
                await DatabaseService(uid: uid).updateUserPoints(
                  uid, 
                  0,
                  0,
                  0,
                  score,
                  0,
                  score,
                );
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Błąd podczas aktualizacji punktów')),
                  );
                }
              }
              if (context.mounted){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseGameScreen()));
              }
               
            },
            child: const Text('Wróć do menu'),
          ),
        ],
      ),
    );
  }

  /// Dispose resources
  @override
  void dispose() {
    colorChangeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double fontSize1 = screenSize.width * 0.09;
    double fontSize2 = screenSize.width * 0.10;
    double fontSize3 = screenSize.width * 0.08;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF4EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF4EC),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sprawdź swój refleks!',
              style: TextStyle(
                fontSize: fontSize3,
                color: const Color(0xFF3D3D3D),
                fontWeight: FontWeight.bold,
              ),
          ),
            SizedBox(height: screenSize.height * 0.02),
            Text(
              gameRunning
                  ? 'Pozostało rund: $roundsLeft'
                  : 'Naciśnij Start, aby zacząć',
              style: TextStyle(
                fontSize: fontSize3,
                color: const Color(0xFF3D3D3D),
              ),
            ),

            SizedBox(height: screenSize.height * 0.05),
            ElevatedButton(
              onPressed: gameRunning ? null : startGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF98B6EC),
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.1,
                  vertical: screenSize.height * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Start',
                style: TextStyle(fontSize: fontSize2, color: Colors.white),
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            GestureDetector(
              onTap: () {
                if (gameRunning && buttonColor == Colors.green) {
                  final lastReactionTime = DateTime.now()
                    .difference(greenStartTime!)
                    .inMilliseconds;

                  setState(() {
                    reactionTime = lastReactionTime;
                    reactionTimes.add(lastReactionTime);
                    score++;
                    buttonColor = Colors.red;
                    roundsLeft--;
                  });

                  colorChangeTimer?.cancel();

                if (roundsLeft == 0) {
                  gameRunning = false;
                  _showGameOverDialog();
                  return;
                }
                _scheduleNextColorChange();
                }
              },
              child: Container(
                width: screenSize.width * 0.7,
                height: screenSize.width * 0.7,
                decoration: BoxDecoration(
                  color: buttonColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$score',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
