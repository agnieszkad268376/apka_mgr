// import 'package:apka_mgr/opto/opto_menu_screen.dart';
import 'package:apka_mgr/loading.dart';
import 'package:apka_mgr/patient/patient_menu_screen.dart';
import 'package:apka_mgr/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:apka_mgr/authorization/signup_screen.dart';

/// Login screen for the application
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool loading = false;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    // Get the screen size of using device to make the responsive layout
    final screenSize = MediaQuery.of(context).size;

    return loading ? Loading() : Scaffold(
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
                  SizedBox(width: width, child: LoginInput(controller: _loginController)),
                  SizedBox(height: spacing),
                  SizedBox(width: width, child: PasswordInput(controller: _passwordController,)),
                  SizedBox(height: spacing),
                  SizedBox(
                    width: width, 
                    child: 
                      ElevatedButton(
                        onPressed: () async{
                          if (_loginController.text.isEmpty || _passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Wpisz swój email i hasło')),
                            );
                          }
                          dynamic result = await _authService.signInWithEmailAndPassword(
                            _loginController.text,
                            _passwordController.text
                          );
                          if (result == null && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Podaj prawidłowy e-mail i hasło')),
                          );
                          loading = false;
                          } else {
                            //TO DO navigate to patient menu screen
                            setState(() {
                              loading = true;
                            });
                            if (context.mounted){
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PatientMenuScreen()),
                            );     
                            }
                                             
                          }
                        },
                        style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDFB4B0),
                        side: const BorderSide(color: Color(0xFFDFB4B0), width: 2.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      child: const Text('Zaloguj się'),
                  ),),
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
  final TextEditingController controller;
  
  const LoginInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
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
        labelText: 'Login',
        fillColor: const Color(0xFFFAF3ED),
        filled: true,
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
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
        filled: true,
      ),
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
