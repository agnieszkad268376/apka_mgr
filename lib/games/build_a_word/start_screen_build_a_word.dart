import 'package:apka_mgr/games/build_a_word/build_a_word.dart';
import 'package:flutter/material.dart';
/// Start screen for the Whack-a-Mole game
/// It shows the instructions for the game and a button to start.
class StartScreenBuildAWord extends StatefulWidget {
  const StartScreenBuildAWord({super.key});

  @override
  State<StartScreenBuildAWord> createState() => _StartScreenBuildAWord();
}

class _StartScreenBuildAWord extends State<StartScreenBuildAWord> {
  String selectedWordLenght = '5-7';
  String selectedNumberOfWords = '5';



  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double fontSize1 = screenSize.width * 0.09;
    double fontSize2 = screenSize.width * 0.08;
    double fontSize3 = screenSize.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFFC1DDFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC1DDFA),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(
            screenSize.width * 0.1,
            screenSize.width * 0.05,
            screenSize.width * 0.1,
            screenSize.width * 0.1,
          ),
          width: screenSize.width * 0.8,
          height: screenSize.height * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.6),
                spreadRadius: 5,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Zbuduj słowo',
                style: TextStyle(
                  fontSize: fontSize1,
                  color: const Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                child: Text(
                  'Na górze ekranu pojawi się słowo. '
                  'Pod nim będzie klawiatura z losowo ułożonymi literami alfabetu. Klikaj pokolei na kolejne litery słowa.\n',
                  style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ilość wyrazów: ',
                      style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D))),
                  SizedBox(width: screenSize.width * 0.02),
                  NumbersOfWordsSelection(
                    initialValue: selectedNumberOfWords,
                    onChanged: (value) {
                      setState(() {
                        selectedNumberOfWords = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ilość liter w słowie: ',
                      style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D))),
                  SizedBox(width: screenSize.width * 0.02),
                  WordsLenghtSelection(
                    initialValue: selectedWordLenght,
                    onChanged: (value) {
                      setState(() {
                        selectedWordLenght = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.05),
              Text(
                'Powodzenia!',
                style: TextStyle(fontSize: fontSize2, color: const Color(0xFF3D3D3D)),
              ),
              SizedBox(height: screenSize.height * 0.05),
              BuildAWordStartButton(
                selectedWordLenght: selectedWordLenght,
                selectedNumberOfWords: selectedNumberOfWords,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Button to start the build a word game
class BuildAWordStartButton extends StatelessWidget {
  final String selectedWordLenght;
  final String selectedNumberOfWords;

  const BuildAWordStartButton({
    super.key,
    required this.selectedWordLenght,
    required this.selectedNumberOfWords,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.05;

    return SizedBox(
      width: screenSize.width * 0.5,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BuildAWordScreen(
                wordLength: selectedWordLenght,
                numberOfWords: selectedNumberOfWords,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF9F97),
          side: const BorderSide(color: Color(0xFFFF9F97), width: 2.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          'Zacznij grę',
          style: TextStyle(fontSize: fontSize, color: const Color(0xFFE7EEFF)),
        ),
      ),
    );
  }
}

/// DropdownMenu to select game time
class NumbersOfWordsSelection extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const NumbersOfWordsSelection({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      items: <String>['2', '5', '7'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) onChanged(newValue);
      },
    );
  }
}

/// DropdownMenu to select mole speed
class WordsLenghtSelection extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const WordsLenghtSelection({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      items: <String>['3-4', '5-7', '8-9'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) onChanged(newValue);
      },
    );
  }
}
