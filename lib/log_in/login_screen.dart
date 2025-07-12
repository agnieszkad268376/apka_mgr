import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Color(0xFF98B6EC),
    
      body: Center(
        child: SingleChildScrollView(
        child: Column(
            children: [
            SizedBox(height: 180),
            Image.asset(
              'images/logo.jpg',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            LoginInput(),
            SizedBox(height: 20),
            PasswordInput(),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
              onPressed: () {
                print('Login Button Pressed');
              },
              child: const Text('Zaloguj się'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDFB4B0),
                side: const BorderSide(color: Color(0xFFDFB4B0), width: 2.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
              ),
              ),
            ),
            SizedBox(height: 100),
             SizedBox(
              width: 300,
              child: ElevatedButton(
              onPressed: () {
                print('Login Button Pressed');
              },
              child: const Text('Zarejestruj się', style: TextStyle(color: Color(0xFFE7EEFF))),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF98B6EC),
                side: const BorderSide(color: Color(0xFFB9CEFF), width: 2.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
              ),
              ),
            ),
          ],
        ),
        )
      ),
    
    );
  }
}



class LoginInput extends StatelessWidget {
  const LoginInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
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
          labelText: 'Login', 
          fillColor: const Color(0xFFFAF3ED), 
          filled: true
      ),
    ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
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
          filled: true
      ),
    ),
    );
  }
}
