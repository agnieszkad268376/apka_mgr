import 'package:apka_mgr/models/excercise_model.dart';
import 'package:flutter/material.dart';

class ExcerciseListTile extends StatelessWidget {
  final ExcerciseModel excercise;
  
  const ExcerciseListTile({super.key, required this.excercise});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Data: ${excercise.date}'),
      subtitle: Text('Opis: ${excercise.description}'),
    );
  }
}