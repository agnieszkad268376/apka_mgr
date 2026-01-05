import 'package:apka_mgr/games/dot_controller/dot_controller.dart';
import 'package:apka_mgr/patient/choose_game_screen.dart';
import 'package:flutter/material.dart';

/// Start screen for the Dot Controller game.
/// It shows the instructions for the game and a button to start.
class StartScreenDotController extends StatefulWidget {
  const StartScreenDotController({super.key});

  @override
  State<StartScreenDotController> createState() => _StartScreenDotControllerState();
} 

/// State for the StartScreenDotController widget
class _StartScreenDotControllerState extends State<StartScreenDotController> {
  // Game time (default 60 seconds)
  String selectedTime = '60 sekund';
  // Number of controlled dots (default 2)
  String selectedNumberOfControlledDots = '2';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double fontSize1 = screenSize.width * 0.09;
    double fontSize3 = screenSize.width * 0.04;

    return Scaffold(
      backgroundColor: const Color(0xFF5D5D5D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5D5D5D),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChooseGameScreen()),
            );
          },
        ),
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
                'Śledź kropkę',
                style: TextStyle(
                  fontSize: fontSize1,
                  color: const Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                child: Text(
                  'Na ekranie zobaczysz 10 kropek, kilka z nich będzie czerwonych, zapamiętaj je.  '
                  'Po naciśnięciu start wszytskie kropi będą zielone i zaczną się poruszać.'
                  'Do końca gry musisz śledzić kropki które były czerwone na początku. Kiedy minie czas gry kropki się zatrzymają'
                  'i będziesz musiał wskazać które kropki które śledziłeś.',
                  style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Czas gry: ',
                      style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D))),
                  SizedBox(width: screenSize.width * 0.02),
                  GameTimeSelection(
                    initialValue: selectedTime,
                    onChanged: (value) {
                      setState(() {
                        selectedTime = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Kontrolowane kropki: ',
                    style: TextStyle(fontSize: fontSize3, color: const Color(0xFF3D3D3D))),
                  SizedBox(width: screenSize.width * 0.02),
                  NumberOfControlledDots(
                    initialValue: selectedNumberOfControlledDots,
                    onChanged: (value) {
                    setState(() {
                      selectedNumberOfControlledDots = value;
                    });
                  },
                 ),
                ],
              ),

              
              SizedBox(height: screenSize.height * 0.05),
              DotControllerScreenButton(
                selectedTime: selectedTime,
                selectedNumberOfControlledDots: selectedNumberOfControlledDots,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Button to start the Whack-a-Mole game
/// Navigates to the DotControllerScreen with selected settings
class DotControllerScreenButton extends StatelessWidget {
  /// Selected game time
  final String selectedTime;
  /// Selected number of controlled dots
  final String selectedNumberOfControlledDots;

  /// Constructor for DotControllerScreenButton
  /// [selectedTime] - game time selected by user
  /// [selectedNumberOfControlledDots] - number of controlled dots selected by user
  const DotControllerScreenButton({
    super.key,
    required this.selectedTime,
    required this.selectedNumberOfControlledDots,
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
              builder: (context) => DotConrollerScreen(
                selectedTime: selectedTime,
                selectedNumberOfControlledDots: selectedNumberOfControlledDots,
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
/// Allows to choose game duration
/// User can select 15, 30, or 60 seconds
class GameTimeSelection extends StatelessWidget {
  // Initial value for the dropdown menu
  final String initialValue;
  // Callback when value changes
  final ValueChanged<String> onChanged;

  /// Constructor for GameTimeSelection
  /// [initialValue] - initial selected value
  /// [onChanged] - callback when value changes
  const GameTimeSelection({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      items: <String>['15 sekund', '30 sekund', '60 sekund'].map((String value) {
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
/// Allows to choose number of controlled dots
/// User can select 1 to 5 dots
class NumberOfControlledDots extends StatelessWidget {
  /// Initial value for the dropdown menu
  final String initialValue;
  /// Callback when value changes
  final ValueChanged<String> onChanged;

  /// Constructor for NumberOfControlledDots
  /// [initialValue] - initial selected value
  /// [onChanged] - callback when value changes
  const NumberOfControlledDots({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      items: <String>['1', '2', '3', '4', '5'].map((String value) {
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
