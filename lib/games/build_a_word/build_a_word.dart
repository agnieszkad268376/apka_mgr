import 'dart:math';
import 'package:apka_mgr/patient/choose_game_screen.dart';
import 'package:apka_mgr/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Main screen for the Build A Word game.
/// It contains the grid of letters and game logic.
class BuildAWordScreen extends StatefulWidget {
  /// User's selctions for game
  final String wordLength;
  final String numberOfWords;

  /// Constructor for BuildAWordScreen
  /// [wordLength] - word length seleted by user
  /// [numberOfWords] - number of words selected by user
  const BuildAWordScreen({
    super.key, 
    required this.wordLength, 
    required this.numberOfWords});

  @override
  State<BuildAWordScreen> createState() => _BuildAWordScreenState();
}

/// State class for BuildAWordScreen
class _BuildAWordScreenState extends State<BuildAWordScreen> {
  // User ID
  String uid = FirebaseAuth.instance.currentUser!.uid;
  // Grid size for letters display
  final int rows = 8;
  final int columns = 4;

  // Random generator
  final random = Random();
  // Strart score
  int score = 0;
  int missedLetters = 0;
  String level = '';
  // Current word and letter indexes
  int currentWordIndex = 1;
  int currentLetterIndex = 0;
  late String currentWord = '';
  List<String> actualGrid = [];
  List<Color> letterColor = [];

  //List with letters from polish alphabet
  List<String> letters = [
    'A', 'Ą', 'B', 'C', 'Ć', 'D', 'E', 'Ę', 'F', 'G', 'H',
    'I', 'J', 'K', 'L', 'Ł', 'M', 'N', 'Ń', 'O', 'Ó', 'P',
    'R', 'S', 'Ś', 'T', 'U', 'W', 'Y', 'Z', 'Ź', 'Ż'
  ];

  // Lists with words with 3 to 4 letters
  List<String> easyWords = [
    'LAS', 'DOM', 'KOT', 'PIES', 'RÓŻA', 'LIPA', 'KURA', 
    'RYBA', 'STÓŁ', 'SEN', 'MYSZ', 'OKNO', 'KĄT', 'GRA',
    'SÓL', 'ŁZA', 'WODA', 'ŻAL', 'TOR', 'RÓG', 'ŁOŚ',
    'KŁOS', 'MÓZG', 'PŁOT', 'ĆMA', 'ĆWIK', 'DĄB', 'BÓG',
    'MUR', 'KREW', 'ŁÓDŹ', 'PĄK', 'SOK', 'MGŁA', 'PAS',
  ];

  // Lists with words with 5 to 7 letters
  List<String> midleWords = [
    'KWIAT', 'DRZEWO', 'ZEGAR', 'MOTYL', 'KSIĄŻKA', 'LAMPA', 'POCIĄG',
    'ŁAWKA', 'MARCHEW', 'SZKOŁA', 'MORZE', 'GÓRKA', 'PTAKI', 'KOBIETA',
    'JABŁKO', 'PIESZY', 'KOTLET', 'RÓŻOWY', 'SŁOŃCE', 'WIATR', 'WZROK',
    'CHMURA', 'ZAMEK', 'OGRÓD', 'PODRÓŻ', 'WIOSNA', 'LOTKA', 'TARKA',
    'LATO', 'JESIEŃ', 'ZIMA', 'MOSTEK', 'TELEFON', 'OKRĘT', 'STATEK',
    'LIŚCIE', 'MIESIĄC', 'TYDZIEŃ', 'DZIEŃ', 'BRZEG', 'PLAŻA', 'FALKA',
  ];

  // Lists with words with 8 to 9 letters
  List<String> hardWords = [
    'SAMOCHÓD', 'MARZYCIEL', 'TELEWIZOR', 'KOMPUTER', 'PRZYRODA',
    'MOTOCYKL', 'PIESZYCH', 'PODRÓŻNIK', 'RODZINNY', 'ZALEŻNOŚĆ',
    'ZWIERZĘTA', 'ŚWIECZNIK', 'SERDECZNY', 'WĘDROWIEC', 'SPOKOJNY',
    'KIEROWCA', 'CODZIENNY', 'PRZYRODA', 'SERDECZNY', 'OPOWIEŚĆ',
    'MUZYKALNY', 'SPOTKANIE', 'OPOWIEŚĆ', 'WIECZORNY', 'SIATKARZ',
    'ZALEŻNOŚĆ', 'RADOŚNIE', 'NIEBIESKI', 'CZERWONY', 'OPIEKUNKA',
  ];

  /// Function to get random word from list based on user's selection
  /// Returns a random word as a String
  String randomWord (){
    List<String> wordList;
    if (widget.wordLength == '3-4') {
      wordList = easyWords;
      level = 'easy';
    } else if (widget.wordLength == '5-7') {
      wordList = midleWords;
      level = 'medium';
    } else {
      wordList = hardWords;
      level = 'hard';
    }
    wordList.shuffle(random);
    return wordList.first;
  }

  void resetGame(){
    score = 0;
    missedLetters = 0;
    currentWordIndex = 1;
    currentLetterIndex = 0;
  }

  /// Method to initialize game state
  @override
  void initState() {
    super.initState();
    resetGame();
    currentWord = randomWord();
    generateActualGrid();
    generateLetterColors();
  }

  /// Function to generate grid with letters
  void generateActualGrid(){
    actualGrid = List.from(letters)..shuffle(random);
  }

  /// Function to generate colors for each letter
  /// Letters can be green or red
  void generateLetterColors(){
    Color green = const Color(0xB30DFF00);
    Color red = const Color(0xB3FF0000);
    List<Color> colors = [green, red];
    for (int i =0 ; i < 32; i++){
      letterColor.add((colors..shuffle()).first);
    }
  }

  // Function to go to the next word
  // when all word are done - show dialog with final score
  void nextWord(){
    setState(() {
      // Check if all words are done
      // if not - generate new word
      // generete new grid and letter colors with each new word
      // if yes - show dialog with final score
      if (currentWordIndex < int.parse(widget.numberOfWords)) {
        currentWordIndex++;
        currentLetterIndex = 0;
        currentWord = randomWord();
        generateActualGrid();
        letterColor.clear();
        generateLetterColors();
      } else {
        // When all words are done
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text('Koniec gry!'),
            content: Text('Twój wynik to: $score punktów'),
            actions: [
              TextButton(
                onPressed: () async {
                  dynamic result = await DatabaseService(uid: uid).addBuildAWordScore(
                    uid,
                    DateTime.now(),
                    score,
                    missedLetters,
                    level
                  );
                  if (result == null) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Błąd podczas zapisywania wyniku')),
                    );
                  }
                  if (!mounted) return;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseGameScreen()));
                  setState(() {
                  });
                }, 
                child: const Text('Wróć do menu')
              ),
              TextButton(
                onPressed: () async {
                  dynamic result = await DatabaseService(uid: uid).addBuildAWordScore(
                    uid,
                    DateTime.now(),
                    score,
                    missedLetters,
                    level
                  );
                  if (result == null) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Błąd podczas zapisywania wyniku')),
                    );
                  }
                  if (!mounted) return;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BuildAWordScreen(
                    wordLength: widget.wordLength,
                    numberOfWords: widget.numberOfWords,
                  )
                  ));
                }, 
                child: const Text('Zagraj ponownie')
              )
            ],
          )
        );
      }
    });
  }

  /// Method to handle letter tap
  /// Updates score and current letter index
  /// [letter] - letter tapped by user
  void onLetterTap(String letter){
    if (currentLetterIndex < currentWord.length && letter == currentWord[currentLetterIndex]) {
      setState(() {
        currentLetterIndex++;
        score += 2; 
      });
      if (currentLetterIndex == currentWord.length) {
        nextWord(); 
      }
    } else {
      setState(() {
        score -= 1;
        missedLetters += 1;
      });
    }
  }

  /// Widget to display current word with colored letters
  /// [screenSize] - size of the screen (used for responsive design)
  Widget currenWordDisplay(screenSize) {
    List<Widget> letterWidgets = [];
    for (int i = 0; i < currentWord.length; i++) {
      letterWidgets.add(
        Text(
          currentWord[i],
          style: TextStyle(
            fontSize: screenSize.width * 0.1,
            fontWeight: FontWeight.bold,
            color: i < currentLetterIndex ? Colors.green : Colors.black,
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: letterWidgets,
    );
  }

  /// Function to build grid with letter
  List<Widget> buildGridItems(){
    /// Get screen size for responsive design
    final screenSize = MediaQuery.of(context).size;
    List <Widget> items = [];

    for(int i = 0; i < rows * columns; i++){
      items.add(
        GestureDetector(
          onTap: () {
            onLetterTap(actualGrid[i]);
          },
          child: 
            Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: 
              Center(
                child: 
                  Text(
                    actualGrid[i], 
                    style: 
                      TextStyle(
                        fontSize: screenSize.width * 0.08, 
                        fontWeight: FontWeight.bold, 
                        color: letterColor[i]
                      ),
                    )
              ),
          ),)
        );
      }
      return items;
    }  

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Size of the grid and padding
    final double topPadding = screenSize.height * 0.3;
    final double bottomPadding = screenSize.height * 0.05;
    final double gridHeight = screenSize.height * 0.65; 

    // padding between tiles
    const double mainAxisSpacing = 8.0;
    const double crossAxisSpacing = 8.0;

    // Size of a tile
    final double tileHeight = (gridHeight - (rows - 1) * mainAxisSpacing) / rows;
    final double tileWidth =
        (screenSize.width - (columns - 1) * crossAxisSpacing) / columns;
    final double childAspectRatio = tileWidth / tileHeight;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          SizedBox(height: topPadding,
          child: Center( 
            child: 
            currenWordDisplay(screenSize),
          ),
          ),
          SizedBox(
            height: gridHeight,
            width: screenSize.width,
            child: GridView.count(
              crossAxisCount: columns,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              childAspectRatio: childAspectRatio,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              children: buildGridItems(),
            ),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}