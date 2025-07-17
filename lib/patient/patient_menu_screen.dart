import 'package:apka_mgr/games/whack_a_mole.dart';
import 'package:flutter/material.dart';

/// Patient view menu screen
/// Paietnt can choose witch game he wants to play
/// Patient can go to settings, check statistics or log out.
class PatientMenuScreen extends StatelessWidget {
  const PatientMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Color(0xFF98B6EC),
    
      body: Center(
        child: Column(
          children: [
            Text('W trakcie przygotowania.....'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WhackAMoleScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDFB4B0),
                side: const BorderSide(color: Color(0xFFDFB4B0), width: 2.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
              ),
              child: const Text('Gra 1'),
            ),

          ],
        )
        


      ),
    
    );
  }
}

