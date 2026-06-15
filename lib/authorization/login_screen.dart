// import 'package:apka_mgr/opto/opto_menu_screen.dart';
import 'package:apka_mgr/loading.dart';
import 'package:apka_mgr/patient/patient_menu_screen.dart';
import 'package:apka_mgr/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:apka_mgr/authorization/signup_screen.dart';
import 'package:video_player/video_player.dart';

/// Login screen for the application
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// The state of the LoginScreen widget
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool loading = false;

  late VideoPlayerController _videoController;


  /// Initializes the state of the LoginScreen widget
  /// Initializes video controller for background animations 
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('images/Vizzy_logo_move.mp4')
  ..initialize().then((_) {
    setState(() {});
    _videoController.setLooping(true);
    _videoController.setVolume(0);
    _videoController.play();
  }).catchError((e) {});
  }

  /// Disposes the controllers when the widget is removed
  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _videoController.dispose();
    super.dispose();
  }


  /// Builds the UI for the LoginScreen 
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
              double width = constraints.maxWidth * 0.80; 
              double spacing = screenSize.height * 0.02; 

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spacing),
                    child: 
                      _videoController.value.isInitialized
                        ? SizedBox(
                            width: screenSize.width * 0.6,
                            child: AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: VideoPlayer(_videoController),
                            ),
                          )
                        : const CircularProgressIndicator(),
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
                          // Validate input and show error messages
                          if (_loginController.text.isEmpty || _passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Wpisz swój email i hasło')),
                            );
                          }
                          // Call the signInWithEmailAndPassword method from AuthService
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

/// Custom widget for the login input field
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

/// Custom widget for the password input field
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

/// Custom widget for the sign-in button
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
