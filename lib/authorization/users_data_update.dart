import 'package:apka_mgr/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsersDataUpdateScreen extends StatefulWidget {
  const UsersDataUpdateScreen({super.key});

  @override
  State<UsersDataUpdateScreen> createState() => _UsersDataUpdateScreenState();
}

class _UsersDataUpdateScreenState extends State<UsersDataUpdateScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _additionalInfoController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final _formKey = GlobalKey<FormState>();

  late Future<DocumentSnapshot> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = DatabaseService(uid: uid).getUserData(uid);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _additionalInfoController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _fillControllers(Map<String, dynamic> userData) {
    if (_nameController.text.isEmpty) {
      _nameController.text = userData['name'] ?? '';
      _birthDateController.text = userData['birthDate'] ?? '';
      _additionalInfoController.text = userData['additionalInfo'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF98B6EC),
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.1,
        backgroundColor: const Color(0xFF98B6EC),
        centerTitle: true,
        title: Text(
          'Edycja danych użytkownika',
          style: TextStyle(fontSize: screenSize.height * 0.04),
        ),
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: _userFuture,
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text('No user data found');
            }

            var userData = snapshot.data!.data() as Map<String, dynamic>;
            _fillControllers(userData);

            String currentEmail = userData['email'] ?? '';
            String currentRole = userData['role'] ?? '';

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [

                    SizedBox(height: screenSize.height * 0.02),

                    Image.asset(
                      'images/logo.jpg',
                      width: screenSize.width * 0.3,
                      height: screenSize.height * 0.3,
                    ),

                    SizedBox(height: screenSize.height * 0.02),

                    NameInput(controller: _nameController),
                    SizedBox(height: screenSize.height * 0.02),

                    BirthDateInput(controller: _birthDateController),
                    SizedBox(height: screenSize.height * 0.02),

                    AdditionalInfo(controller: _additionalInfoController),
                    SizedBox(height: screenSize.height * 0.02),

                    SizedBox(
                      width: screenSize.width * 0.5,
                      height: screenSize.height * 0.08,
                      child: ElevatedButton(
                        onPressed: () async {

                          if (!_formKey.currentState!.validate()) return;

                          try {
                            await DatabaseService(uid: uid).updateUserData(
                              uid,
                              currentEmail,
                              _nameController.text,
                              currentRole,
                              _birthDateController.text,
                              _additionalInfoController.text,
                            );

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Dane użytkownika zaktualizowane pomyślnie'),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Błąd podczas aktualizacji danych użytkownika'),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDFB4B0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.0),
                          ),
                        ),
                        child: Text(
                          'Edytuj dane',
                          style: TextStyle(
                            fontSize: screenSize.height * 0.03,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
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
        controller: controller,
        validator: (value) =>
            value == null || value.isEmpty ? 'Wpisz swoje imię' : null,
        decoration: _inputDecoration('Imię'),
      ),
    );
  }
}

class BirthDateInput extends StatelessWidget {
  final TextEditingController controller;

  const BirthDateInput({super.key, required this.controller});

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'Wybierz datę urodzenia',
    );

    if (pickedDate != null) {
      String formatted =
          "${pickedDate.day.toString().padLeft(2, '0')}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.year}";
      controller.text = formatted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: controller,
        readOnly: true, // ❗ blokuje wpisywanie ręczne
        onTap: () => _selectDate(context),
        validator: (value) =>
            value == null || value.isEmpty ? 'Wybierz datę urodzenia' : null,
        decoration: InputDecoration(
          labelText: 'Data urodzenia',
          suffixIcon: const Icon(Icons.calendar_today),
          filled: true,
          fillColor: const Color(0xFFFAF3ED),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFCEC3BA), width: 5),
            borderRadius: BorderRadius.circular(23),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFCEC3BA), width: 5),
            borderRadius: BorderRadius.circular(23),
          ),
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
        controller: controller,
        maxLines: 6,
        decoration: _inputDecoration('Dodatkowe informacje'),
      ),
    );
  }
}

InputDecoration _inputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    filled: true,
    fillColor: const Color(0xFFFAF3ED),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFCEC3BA), width: 5),
      borderRadius: BorderRadius.circular(23),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFCEC3BA), width: 5),
      borderRadius: BorderRadius.circular(23),
    ),
  );
}