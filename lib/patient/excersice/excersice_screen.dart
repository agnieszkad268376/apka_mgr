import 'package:apka_mgr/patient/excersice/add_excersice.dart';
import 'package:apka_mgr/patient/excersice/excerssice_story.dart';
import 'package:flutter/material.dart';

/// Ekran logowania do aplikacji
/// Użytkownik może wprowadzić login i hasło, a następnie zalogować się lub zarejestrować. 
class ExcersiceScreen extends StatelessWidget {
  const ExcersiceScreen({super.key});

  @override 
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double fontSize = screenSize.height * 0.03;
    return 
    Scaffold(
      backgroundColor: Color(0xFFFFF1E3),
      appBar: AppBar(
         toolbarHeight: screenSize.height * 0.1,
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFF98B6EC),
        centerTitle: true,
        title: Text('Ćwiczenia', style: TextStyle(fontSize: fontSize),),
      ),
    
      body: SingleChildScrollView(
        child: Center(
          child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height *  0.02),
              Image.asset(
                'images/logo.jpg',
                width: screenSize.width * 0.6,
                fit: BoxFit.contain,
              ),
              SizedBox(height: screenSize.height *  0.05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFCF4EC),
                fixedSize: Size(screenSize.width * 0.85, screenSize.height * 0.09),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide( 
                    color: Color(0xFFCEC3BA),  
                    width: 2,             
                  ),
                ),
              ),
                onPressed: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const AddExcerciseScreen()),
                  );
                },
               child: 
               Text(
                'Dodaj dzisiaj wykonane ćwiczenia',
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color:Color(0xFFA49C94)),
              ),),
              SizedBox(height: screenSize.height *  0.05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFCF4EC),
                fixedSize: Size(screenSize.width * 0.85, screenSize.height * 0.09),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide( 
                    color: Color(0xFFCEC3BA),  
                    width: 2,             
                  ),
                ),
              ),
                onPressed: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const ExcerssiceStoryScreen()),
                  );
                },
               child: 
               Text(
                'Historia ćwiczeń',
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color:Color(0xFFA49C94)),
              ),),
            ],
          ),
        ),
      ),
    
    );
  }
}

