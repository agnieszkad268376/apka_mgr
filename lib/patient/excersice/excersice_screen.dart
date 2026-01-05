import 'package:apka_mgr/patient/excersice/add_excersice.dart';
import 'package:apka_mgr/patient/excersice/excerssice_story.dart';
import 'package:flutter/material.dart';

/// Ekran logowania do aplikacji
/// Użytkownik może wprowadzić login i hasło, a następnie zalogować się lub zarejestrować. 
class ExcersiceScreen extends StatelessWidget {
  const ExcersiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Color(0xFF98B6EC),
      appBar: AppBar(
        backgroundColor: Color(0xFF98B6EC),
        title: Text('Ćwiczenia'),
      ),
    
      body: SingleChildScrollView(
        child: Center(
          child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const AddExcerciseScreen()),
                  );
                },
               child: 
               Text(
                'Dzisiaj wykonane ćwiczenia',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const ExcerssiceStoryScreen()),
                  );
                },
               child: 
               Text(
                'Historia ćwiczeń',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),),
            ],
          ),
        ),
      ),
    
    );
  }
}

