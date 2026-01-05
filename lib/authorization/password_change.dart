import 'package:apka_mgr/services/auth.dart';
import 'package:flutter/material.dart';


class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({super.key});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reentryPasswordController = TextEditingController(); 
  String selectedRole = 'user'; 

  final AuthService _authService = AuthService(); 
  // Instantiate a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
      appBar: AppBar(
        backgroundColor: Color(0xFF98B6EC),
        title: Text('Zmiana hasła'),
      ),
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
            PasswordInput(controller: _passwordController,),
            SizedBox(height: 20),
            ReentryPasswordInput(controller: _reentryPasswordController,),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
              onPressed: () async {
                
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
                bool result = await _authService.resetPassword(
                  _passwordController.text
                );

                if (result == false && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Błąd podczas zmiany hasła')),
                  );
                } else {
                  if (context.mounted){
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Zmiana hasła zakończona sukcesem')),
                  );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDFB4B0),
                side: const BorderSide(color: Color(0xFFDFB4B0), width: 2.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
              ),
              child: const Text('Zmień hasło'),
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
          labelText: 'Nowe hasło', 
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
          labelText: 'Powtórz hasło', 
          fillColor: const Color(0xFFFAF3ED), 
          filled: true
      ),
    ),
    );
  }
}




