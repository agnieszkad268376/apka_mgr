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
      backgroundColor: const Color.fromARGB(255, 232, 219, 206),
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.1,
        backgroundColor: const Color(0xFF98B6EC),
        centerTitle: true,
        title: Text(
          'Edycja danych',
          style: TextStyle(fontSize: screenSize.height * 0.035),
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
            String currentAge = userData['age'] ?? '';
            String currentName = userData['name'] ?? '';
            String currentInfo = userData['info'] ?? '';

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.02),
                    Container(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF3ED),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.3),
                            spreadRadius: 5,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person, size: screenSize.height * 0.03),
                                SizedBox(width: screenSize.width * 0.02),
                                Text('Twoje imię', style: TextStyle(fontSize: screenSize.height * 0.02),),
                              ],
                            ),
                            SizedBox(height: screenSize.height * 0.01),
                            NameInput(controller: _nameController, initName: currentName),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Container(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF3ED),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.3),
                            spreadRadius: 5,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.cake, size: screenSize.height * 0.03),
                                SizedBox(width: screenSize.width * 0.02),
                                Text('Twoja data urodzenia',  style: TextStyle(fontSize: screenSize.height * 0.02)),
                              ],
                            ),
                            SizedBox(height: screenSize.height * 0.01),
                            BirthDateInput(controller: _birthDateController, initBirthDate: currentAge),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Container(
                      height: screenSize.height * 0.3,
                      width: screenSize.width * 0.8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF3ED),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.3),
                            spreadRadius: 5,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info, size: screenSize.height * 0.03),
                                SizedBox(width: screenSize.width * 0.02),
                                Text('Dodatkowe informacje',  style: TextStyle(fontSize: screenSize.height * 0.02)),
                              ],
                            ),
                            SizedBox(height: screenSize.height * 0.01),
                            AdditionalInfo(controller: _additionalInfoController),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: screenSize.height * 0.05),

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
  final String initName;
  const NameInput({super.key, required this.controller, this.initName = ''});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.7,
      child: TextFormField( 
        controller: controller,
        validator: (value) =>
            value == null || value.isEmpty ? 'Wpisz swoje imię' : null,
        decoration: _inputDecoration(initName),
      ),
    );
  }
}

class BirthDateInput extends StatelessWidget {
  final TextEditingController controller;
  final String initBirthDate;
  const BirthDateInput({super.key, required this.controller, this.initBirthDate = ''});

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year),
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
    final screenSize = MediaQuery.of(context).size; 
    return SizedBox(
      width: screenSize.width * 0.7,
      child: TextFormField(
        controller: controller,
        readOnly: true, 
        onTap: () => _selectDate(context),
        validator: (value) =>
            value == null || value.isEmpty ? 'Wybierz datę urodzenia' : null,
        decoration: InputDecoration(
          labelText: initBirthDate,
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
    final screenSize = MediaQuery.of(context).size;
    
    return SizedBox(
      width: screenSize.width * 0.7,
      child: TextField(
        controller: controller,
        maxLines: 9,
        decoration: _inputDecoration('Dodatkowe informacje'),
      ),
    );
  }
}

InputDecoration _inputDecoration(String label) {
  return InputDecoration(
    hintText: label,
    labelText: label,
    filled: true,
    fillColor: const Color(0xFFFAF3ED),
    floatingLabelBehavior: FloatingLabelBehavior.never,
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