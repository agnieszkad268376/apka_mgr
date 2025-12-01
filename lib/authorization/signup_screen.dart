import 'package:apka_mgr/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Registration screen 
/// Users enter their login, password and select a role
/// then user is registered in the application.
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final AuthService _authService = AuthService(); 

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Color(0xFF98B6EC),
    
      body: Center(
        child: SingleChildScrollView(
        child: Column(
            children: [
            SizedBox(height: 10),
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
            ReentryPasswordInput(),
            SizedBox(height: 20),
            RoleDropDownMenu(),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
              onPressed: () async{
                dynamic result = await _authService.signInAnon();
                if (result == null){
                  print('error signing in');
                } else {
                  print('signed in');
                  print(result);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDFB4B0),
                side: const BorderSide(color: Color(0xFFDFB4B0), width: 2.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
              ),
              child: const Text('Zarejestruj się'),
              ),
            ),
          ],
        ),
        )
      ),
    
    );
  }
}

/// Widget for the login input field
/// This widget creates a text field for user login input.
/// It includes styling for the text field, such as border color and radius.
class LoginInput extends StatelessWidget {
  const LoginInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
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

/// Widget for the password input field
/// This widget creates a text field for user password input. 
/// It includes styling for the text field, such as border color and radius.
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

/// Widget for the reentry password input field
/// This widget creates a text field for user to re-enter their password.
class ReentryPasswordInput extends StatelessWidget {
  const ReentryPasswordInput({super.key});

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
          labelText: 'Powtóz hasło', 
          fillColor: const Color(0xFFFAF3ED), 
          filled: true
      ),
    ),
    );
  }
}


class RoleDropDownMenu extends StatelessWidget {
  const RoleDropDownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFCEC3BA), width: 5.0),
            borderRadius: BorderRadius.circular(23.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFCEC3BA), width: 5.0),
            borderRadius: BorderRadius.circular(23.0),
          ),
          labelText: 'Rola', 
          fillColor: const Color(0xFFFAF3ED), 
          filled: true
        ),
        items: const [
          DropdownMenuItem(value: 'admin', child: Text('Optometrysta')),
          DropdownMenuItem(value: 'user', child: Text('Pacjent')),
        ],
        onChanged: (value) {
          //print('Selected role: $value');
        },
      ),
    );
    
  }
}

