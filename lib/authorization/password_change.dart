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
    final screenSize = MediaQuery.of(context).size;
    return 
    Scaffold(
      backgroundColor: Color(0xFFE8DBCE),
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.1,
        backgroundColor: const Color(0xFF98B6EC),
        centerTitle: true,
        title: Text(
          'Ustawienia',
          style: TextStyle(fontSize: screenSize.height * 0.035),
        ),
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
              width: screenSize.width * 0.5,
              height: screenSize.height * 0.5,
            ),
            SizedBox(height: screenSize.height * 0.01),
            PasswordInput(controller: _passwordController,),
            ReentryPasswordInput(controller: _reentryPasswordController,),
            SizedBox(
              width: screenSize.height * 0.5,
              height: screenSize.height * 0.08,
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
              child: Text('Zmień hasło', style: TextStyle(fontSize: screenSize.height * 0.035, color: Colors.black),),
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
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.8,
      height: screenSize.height * 0.08,
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
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.8,
      height: screenSize.height * 0.08,
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




