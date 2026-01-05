import 'package:apka_mgr/models/excercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExcerciseList extends StatefulWidget {
  const ExcerciseList({super.key});

  @override
  State<ExcerciseList> createState() => _ExcerciseListState();
}

class _ExcerciseListState extends State<ExcerciseList> {
  @override
  Widget build(BuildContext context) {

    final excercisesSnapshot = Provider.of<List<ExcerciseModel>?>(context);

    if (excercisesSnapshot != null){
      // print each document data to console
      for (var excercise in excercisesSnapshot) {
        print('Excercise ID: ${excercise.uid}, Data: ${excercise.date}, Description: ${excercise.description}');
      }
    }

    return ListView.builder(
      itemCount: excercisesSnapshot?.length ?? 0,
      itemBuilder: (context, index) {
        final excercise = excercisesSnapshot?[index];
        return ListTile(
          title: Text('Data: ${excercise!.date}'),
          subtitle: Text('Opis: ${excercise.description}'),
        );
      },
    );
  }
}