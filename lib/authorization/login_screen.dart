// import 'package:apka_mgr/opto/opto_menu_screen.dart';
import 'package:apka_mgr/patient/choose_game_screen.dart';
import 'package:apka_mgr/patient/patient_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:apka_mgr/authorization/signup_screen.dart';

/// Login screen for the application
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size of using device to make the responsive layout
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF98B6EC),
      body: Center(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth * 0.80; // 85% of screen width
              double spacing = screenSize.height * 0.02; // vertical spacing

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spacing),
                    child: Image.asset(
                      'images/logo.jpg',
                      width: screenSize.width * 0.8,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: width, child: const LoginInput()),
                  SizedBox(height: spacing),
                  SizedBox(width: width, child: const PasswordInput()),
                  SizedBox(height: spacing),
                  SizedBox(width: width, child: const LoginButton()),
                  SizedBox(height: spacing * 0.8),
                  SizedBox(width: width, child: const SigninButton()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LoginInput extends StatelessWidget {
  const LoginInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCEC3BA), width: 5.0),
          borderRadius: BorderRadius.circular(23.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCEC3BA), width: 5.0),
          borderRadius: BorderRadius.circular(23.0),
        ),
        labelText: 'Login',
        fillColor: const Color(0xFFFAF3ED),
        filled: true,
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCEC3BA), width: 5.0),
          borderRadius: BorderRadius.circular(23.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCEC3BA), width: 5.0),
          borderRadius: BorderRadius.circular(23.0),
        ),
        labelText: 'Hasło',
        fillColor: const Color(0xFFFAF3ED),
        filled: true,
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PatientMenuScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFDFB4B0),
        side: const BorderSide(color: Color(0xFFDFB4B0), width: 2.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: const Text('Zaloguj się'),
    );
  }
}

class SigninButton extends StatelessWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF98B6EC),
        side: const BorderSide(color: Color(0xFFB9CEFF), width: 2.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()),
        );
      },
      child: const Text(
        'Zarejestruj się',
        style: TextStyle(color: Color(0xFFE7EEFF)),
      ),
    );
  }
}
