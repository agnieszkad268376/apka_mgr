import 'dart:math';

import 'package:flutter/material.dart';

class BuildAWordScreen extends StatefulWidget {
  final String wordLength;
  final String numberOfWords;
  const BuildAWordScreen({super.key, required this.wordLength, required this.numberOfWords});

  @override
  State<BuildAWordScreen> createState() => _BuildAWordScreenState();
}

class _BuildAWordScreenState extends State<BuildAWordScreen> {
  final int rows = 8;
  final int columns = 4;
  final random = Random();
  int score = 0;
  int currentWordIndex = 1;
  int currentLetterIndex = 0;
  late String currentWord = '';
  List<String> actualGrid = [];

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
    'MUR', 'KREW', 'ŁÓDŹ', 'PĄK', 'SOK', 'MGŁA', 'PAS'
  ];

  // Lists with words with 5 to 7 letters
  List<String> midleWords = [
    'KWIAT', 'DRZEWO', 'ZEGAR', 'MOTYL', 'KSIĄŻKA', 'LAMPA', 'POCIĄG',
    'ŁAWKA', 'MARCHEW', 'SZKOŁA', 'MORZE', 'GÓRKA', 'PTAKI', 'KOBIETA'
    'JABŁKO', 'PIESZY', 'KOTLET', 'RÓŻOWY', 'SŁOŃCE', 'WIATR', 'WZROK',
    'CHMURA', 'ZAMEK', 'OGRÓD', 'PODRÓŻ', 'WIOSNA', 'LOTKA', 'TARKA',
    'LATO', 'JESIEŃ', 'ZIMA', 'MOSTEK', 'TELEFON', 'OKRĘT', 'STATEK',
    'LIŚCIE', 'MIESIĄC', 'TYDZIEŃ', 'DZIEŃ', 'BRZEG', 'PLAŻA', 'FALKA'
  ];

  // Lists with words with 8 to 9 letters
  List<String> hardWords = [
    'SAMOCHÓD', 'MARZYCIEL', 'TELEWIZOR', 'KOMPUTER', 'PRZYRODA'
    'MOTOCYKL', 'PIESZYCH', 'PODRÓŻNIK', 'RODZINNY', 'ZALEŻNOŚĆ',
    'ZWIERZĘTA', 'ŚWIECZNIK', 'SERDECZNY', 'WĘDROWIEC', 'SPOKOJNY',
    'KIEROWCA', 'CODZIENNY', 'PRZYRODA', 'SERDECZNY', 'OPOWIEŚĆ',
    'MUZYKALNY', 'SPOTKANIE', 'OPOWIEŚĆ', 'WIECZORNY', 'SIATKARZ'
    'ZALEŻNOŚĆ', 'RADOŚNIE', 'NIEBIESKI', 'CZERWONY', 'OPIEKUNKA',
  ];

  String randomWord (){
    List<String> wordList;
    if (widget.wordLength == '3-4') {
      wordList = easyWords;
    } else if (widget.wordLength == '5-7') {
      wordList = midleWords;
    } else {
      wordList = hardWords;
    }
    wordList.shuffle(random);
    return wordList.first;
  }

  @override
  void initState() {
    super.initState();
    currentWord = randomWord();
    generateActualGrid();
  }

  void generateActualGrid(){
    actualGrid = List.from(letters)..shuffle(random);
  }

  void nextWord(){
    setState(() {
      if (currentWordIndex < int.parse(widget.numberOfWords)) {
        currentWordIndex++;
        currentLetterIndex = 0;
        currentWord = randomWord();
        generateActualGrid();
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Koniec gry!'),
            content: Text('Twój wynik to: $score punktów'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }, 
                child: const Text('OK')
              )
            ],
          )
        );
      }
    });
  }

  void onLetterTap(String letter){
    if (currentLetterIndex < currentWord.length && letter == currentWord[currentLetterIndex]) {
      setState(() {
        currentLetterIndex++;
        score += 10; 
      });
      if (currentLetterIndex == currentWord.length) {
        nextWord(); 
      }
    } else {
      setState(() {
        score -= 5;
      });
    }
  }

  List<Widget> buildGridItems(){
    final screenSize = MediaQuery.of(context).size;
    List <Widget> items = [];

    Color green = const Color(0xB30DFF00);
    Color red = const Color(0xB3FF0000);
    List<Color> colors = [green, red];

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
                        color: (colors..shuffle()).first
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
          SizedBox(//height: topPadding,
          child: Center( 
            child: 
            Text(currentWord, style: TextStyle(color: Color.fromARGB(255, 51, 51, 51), fontSize: screenSize.width * 0.1),),
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
          //SizedBox(height: bottomPadding), 
          Text('Wynik: $score', style: TextStyle(color: Color.fromARGB(255, 47, 47, 47), fontSize: screenSize.width * 0.06),),
          Text('Słowo ${currentWordIndex}/${widget.numberOfWords}', style: TextStyle(color: Color.fromARGB(255, 47, 47, 47), fontSize: screenSize.width * 0.06),),
          Text('$currentLetterIndex/${currentWord.length} liter', style: TextStyle(color: Color.fromARGB(255, 47, 47, 47), fontSize: screenSize.width * 0.06),),
          Text('$currentWord'),
        ],
      ),
    );
  }
}