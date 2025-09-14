import 'package:apka_mgr/authorization/setting_screen.dart';
import 'package:apka_mgr/games/catch_a_ball/start_Screen_catch_a_ball.dart';
import 'package:apka_mgr/games/whack_a_mol/start_screen_whack_a_mole.dart';
import 'package:apka_mgr/patient/progress_journal.dart';
import 'package:flutter/material.dart';

/// Patient view menu screen
/// Paietnt can choose witch game he wants to play
/// Patient can go to settings, check statistics or log out.
class PatientMenuScreen extends StatelessWidget {
  const PatientMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return 
    Scaffold(
      backgroundColor: Color(0xFFFCF4EC),
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.1,
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFF98B6EC),
        centerTitle: true,
        title: const Text('Menu Pacjenta'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF98B6EC)),
              child: Text('Opcje????', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Ustawienia'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart_outlined),
              title: const Text('Dziennik postępów'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProgressJournal()),
                );
              },
            ),
            SizedBox(height: screenSize.height * 0.6),
            FloatingActionButton(onPressed: (){}, child: const Icon(Icons.logout)),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: IconButton(
                  icon: Image.asset('images/whack_a_mole.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenWhackAMole()),
                    );
                  },
                ),
                ),
                SizedBox(width: screenSize.width * 0.05),
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: IconButton(
                  icon: Image.asset('images/whack_a_mole.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenCatchABall()),
                    );
                  },
                ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: IconButton(
                  icon: Image.asset('images/whack_a_mole.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenWhackAMole()),
                    );
                  },
                ),
                ),
                SizedBox(width: screenSize.width * 0.05),
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: IconButton(
                  icon: Image.asset('images/whack_a_mole.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenWhackAMole()),
                    );
                  },
                ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: IconButton(
                  icon: Image.asset('images/whack_a_mole.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenWhackAMole()),
                    );
                  },
                ),
                ),
                SizedBox(width: screenSize.width * 0.05),
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: IconButton(
                  icon: Image.asset('images/whack_a_mole.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreenWhackAMole()),
                    );
                  },
                ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}

