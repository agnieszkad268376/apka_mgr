import 'package:apka_mgr/authorization/setting_screen.dart';
import 'package:apka_mgr/patient/achivments_screen.dart';
import 'package:apka_mgr/patient/choose_game_screen.dart';
import 'package:apka_mgr/patient/excersice_screen.dart';
import 'package:apka_mgr/patient/progress_journal.dart';
import 'package:apka_mgr/patient/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Patient view menu screen
/// 
class PatientMenuScreen extends StatefulWidget {
  const PatientMenuScreen({super.key});

  @override
  State<PatientMenuScreen> createState() => _PatientMenuScreenState();
}

class _PatientMenuScreenState extends State<PatientMenuScreen>
with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildShimmerCircle(Size screenSize, String text) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Shimmer.fromColors(
        baseColor: const Color(0xFFFF9F97), // kolor bazowy
        highlightColor: const Color.fromARGB(255, 247, 108, 96), // kolor „fali”
        child: Container(
          width: screenSize.width * 0.4,
          height: screenSize.width * 0.4,
          decoration: const BoxDecoration(
            color: Color(0xFFFF9F97),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Container(
        width: screenSize.width * 0.3,
        height: screenSize.width * 0.3,
        decoration: const BoxDecoration(
          color: Color(0xFFFFF1E3),
          shape: BoxShape.circle,
        ),
      ),
      Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromARGB(255, 47, 47, 47),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],);
    }

  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return 
    Scaffold(
      backgroundColor: Color(0xFFFFF1E3),
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
              leading: const Icon(Icons.calendar_month),
              title: const Text('Kalendarz postępów'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProgressJournal()),
                );
              },
            ),
            SizedBox(height: screenSize.height * 0.3),
            ElevatedButton(onPressed: (){}, child: const Icon(Icons.logout)),
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
                _buildShimmerCircle(screenSize, 'Punkty\nogólne'),
                SizedBox(width: screenSize.width * 0.1),
                _buildShimmerCircle(screenSize, 'Punkty\ndziś'),
              ],
            ),
            SizedBox(height: screenSize.height * 0.08),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFCF4EC),
                fixedSize: Size(screenSize.width * 0.9, screenSize.height * 0.09),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide( 
                    color: Color(0xFFCEC3BA),  
                    width: 2,             
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChooseGameScreen()),
                    );
              },
              child: const Text('Gry', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA49C94)),),
            ),
            SizedBox(height: screenSize.height * 0.02),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFCF4EC),
                fixedSize: Size(screenSize.width * 0.9, screenSize.height * 0.09),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide( 
                    color: Color(0xFFCEC3BA),  
                    width: 2,             
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ExcersiceScreen()),
                    );
              },
              child: const Text('Ćwiczenia', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA49C94)),),
            ),
            SizedBox(height: screenSize.height * 0.02),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFCF4EC),
                fixedSize: Size(screenSize.width * 0.9, screenSize.height * 0.09),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide( 
                    color: Color(0xFFCEC3BA), 
                    width: 2,             
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AchivmentsScreen()),
                    );
              },
              child: const Text('Osiągnięcia', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA49C94)),),
            ),
            SizedBox(height: screenSize.height * 0.02),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFCF4EC),
                fixedSize: Size(screenSize.width * 0.9, screenSize.height * 0.09),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide( 
                    color: Color(0xFFCEC3BA),  
                    width: 2,           
                  ),  
                ),
              ),
              onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StatisticsScreen()),
                    );
              },
              child: const Text('Statystyki', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA49C94)),),
            ),

          ],
        ),
      )
    );
  }
}

