import 'package:apka_mgr/authorization/login_screen.dart';
import 'package:apka_mgr/models/app_user.dart';
import 'package:apka_mgr/patient/patient_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser?>(context);

    // TO DO
    //RETURN HOME OR AUTH BASED ON STATUS
    if (user == null){
      return LoginScreen();
    } else {
      return PatientMenuScreen();
    }
  }
}
