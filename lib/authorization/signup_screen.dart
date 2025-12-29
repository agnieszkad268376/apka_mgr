import 'package:apka_mgr/authorization/login_screen.dart';
import 'package:apka_mgr/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Registration screen 
/// Users enter their login, password and select a role
/// then user is registered in the application.
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reentryPasswordController = TextEditingController(); 
  String selectedRole = 'user'; 

  final AuthService _authService = AuthService(); 
  // Instantiate a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _reentryPasswordController.dispose();
    super.dispose();
  }

  void roleChange(String? value) {
    setState(() {
      selectedRole = value ?? 'user';
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Color(0xFF98B6EC),
    
      body: Center(
        child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
            SizedBox(height: 10),
            Image.asset(
              'images/logo.jpg',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            LoginInput(controller: _loginController,),
            SizedBox(height: 20),
            PasswordInput(controller: _passwordController,),
            SizedBox(height: 20),
            ReentryPasswordInput(controller: _reentryPasswordController,),
            SizedBox(height: 20),
            RoleDropDownMenu(selectedRole: selectedRole, onChanged: roleChange,),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
              onPressed: () async {
                if (_loginController.text.isEmpty || _passwordController.text.isEmpty || _reentryPasswordController.text.isEmpty) {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Proszę wypełnić wszystkie pola')),
                  );
                  return;
                }
                if (_loginController.text.contains(' ')) {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login nie może zawierać spacji')),
                  );
                  return;
                }
                if (!_loginController.text.contains('@') || !_loginController.text.contains('.') ) {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Wpisz poprawny adres email')),
                  );
                  return;
                }
                if (_passwordController.text != _reentryPasswordController.text) {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Hasła nie są identyczne')),
                  );
                  return;
                }
                if (_passwordController.text.length < 6) {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Hasło musi mieć co najmniej 6 znaków')),
                  );
                  return;
                }
                dynamic result = await _authService.registerWithEmailAndPassword(
                  _loginController.text,
                  _passwordController.text
                );
                if (result == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Błąd podczas rejestracji użytkownika')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Rejestracja zakończona sukcesem')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
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
      )
    );
  }
}

/// Widget for the login input field
/// This widget creates a text field for user login input.
/// It includes styling for the text field, such as border color and radius.
class LoginInput extends StatelessWidget {
  final TextEditingController controller;
  
  const LoginInput({super.key, required this.controller});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Proszę wprowadzić login';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFCEC3BA), width: 5.0),
            borderRadius: BorderRadius.circular(23.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFCEC3BA), width: 5.0),
            borderRadius: BorderRadius.circular(23.0),
          ),
          labelText: 'E-mail', 
          fillColor: const Color(0xFFFAF3ED), 
          filled: true,
      ),
    ),
    );
  }
}

/// Widget for the password input field
/// This widget creates a text field for user password input. 
/// It includes styling for the text field, such as border color and radius.
class PasswordInput extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: controller,
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
  final TextEditingController controller;

  const ReentryPasswordInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: controller,
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
  final String? selectedRole;
  final ValueChanged<String?>? onChanged;

  const RoleDropDownMenu({super.key, this.selectedRole, this.onChanged});

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
        onChanged: onChanged,
      ),
    );
    
  }
}

