import 'package:apka_mgr/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// User data update screen
/// User can update their name, birth date, and additional information.
class UsersDataUpdateScreen extends StatefulWidget {
  const UsersDataUpdateScreen({super.key});

  @override
  State<UsersDataUpdateScreen> createState() => _UsersDataUpdateScreenState();
}

/// State class for UsersDataUpdateScreen
class _UsersDataUpdateScreenState extends State<UsersDataUpdateScreen> {
  // Controllers for text input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _additionalInfoController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  String uid = FirebaseAuth.instance.currentUser!.uid;

  // Instantiate a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _additionalInfoController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Color(0xFF98B6EC),
      appBar: AppBar(
        backgroundColor: Color(0xFF98B6EC),
        title: Text('Zmiana danych użytkownika'),
      ),    
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: DatabaseService(uid: uid).getUserData(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text('No user data found');
            }

            var userData = snapshot.data!.data() as Map<String, dynamic>;
            String currentEamail = userData['email'];
            String currentRole = userData['role'];

            return SingleChildScrollView(
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
              NameInput(controller: _nameController,),
              SizedBox(height: 20),
              BirthDateInput(controller: _birthDateController,),
              SizedBox(height: 20),
              AdditionalInfo(controller: _additionalInfoController),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                onPressed: () async {
          
                  if (_nameController.text.contains(' ')) {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login nie może zawierać spacji')),
                    );
                    return;
                  }
                  if (!_nameController.text.contains('@') || !_nameController.text.contains('.') ) {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Wpisz poprawny adres email')),
                    );
                    return;
                  }

                  dynamic result = await DatabaseService(uid: '').updateUserData(
                    FirebaseAuth.instance.currentUser!.uid,
                    currentEamail,
                    _nameController.text,
                    currentRole,
                    _birthDateController.text,
                    _additionalInfoController.text,
                  );

                  if (result == null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Błąd podczas aktualizacji danych użytkownika')),
                    );
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Dane użytkownika zaktualizowane pomyślnie')),
                      );
                    }
                  }
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDFB4B0),
                  side: const BorderSide(color: Color(0xFFDFB4B0), width: 2.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
                ),
                child: const Text('Edytuj dane'),
                ),
              ),
            ],
          ),
          )
                ),
        );
  }),
      )
    );
  }
}


class NameInput extends StatelessWidget {
  final TextEditingController controller;
  
  const NameInput({super.key, required this.controller});
  
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
          labelText: 'Imię', 
          fillColor: const Color(0xFFFAF3ED), 
          filled: true,
      ),
    ),
    );
  }
}

class AdditionalInfo extends StatelessWidget {
  final TextEditingController controller;
  
  const AdditionalInfo({super.key, required this.controller});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        maxLines: 8,
        minLines: 5,
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
          labelText: 'Dodatkowe informacje', 
          fillColor: const Color(0xFFFAF3ED), 
          filled: true,
      ),
    ),
    );
  }
}

class BirthDateInput extends StatelessWidget {
  final TextEditingController controller;
  
  const BirthDateInput({super.key, required this.controller});
  
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
          labelText: 'Data urodzenia (DD-MM-RRRR)', 
          fillColor: const Color(0xFFFAF3ED), 
          filled: true,
      ),
    ),
    );
  }
}




