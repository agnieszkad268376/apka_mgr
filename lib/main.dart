import 'package:apka_mgr/services/auth.dart';
import 'package:apka_mgr/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:apka_mgr/models/app_user.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Main function that runs the app.
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);



  runApp(MyApp());
}

/// The main application widget.
/// It serves as the entry point for the Flutter application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return StreamProvider<AppUser?>.value(
      // listen to authentication state changes
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('pl', 'PL'),

  supportedLocales: const [
    Locale('pl', 'PL'),
  ],

  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
        home: Wrapper(),
      )
    );
  }
}