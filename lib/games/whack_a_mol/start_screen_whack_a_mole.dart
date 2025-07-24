import 'package:flutter/material.dart';
import 'package:apka_mgr/games/whack_a_mol/whack_a_mole.dart';


class StartScreenWhackAMole extends StatelessWidget {
  const StartScreenWhackAMole({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF98B6EC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Whack a Mole!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}