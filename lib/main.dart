import 'package:apka_mgr/authorization/login_screen.dart';
import 'package:apka_mgr/authorization/signup_screen.dart';
import 'package:apka_mgr/opto/opto_menu_screen.dart';
import 'package:apka_mgr/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Main function that runs the app.
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

/// The main application widget.
/// It serves as the entry point for the Flutter application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
  );
}
}