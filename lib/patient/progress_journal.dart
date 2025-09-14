import 'package:flutter/material.dart';

/// Ekran logowania do aplikacji
/// Użytkownik może wprowadzić login i hasło, a następnie zalogować się lub zarejestrować. 
class ProgressJournal extends StatelessWidget {
  const ProgressJournal({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Color(0xFF98B6EC),
    
      body: Center(
        child: Text('W trakcie przygotowania...'),
      ),
    
    );
  }
}

