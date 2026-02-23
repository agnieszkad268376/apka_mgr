import 'package:apka_mgr/models/excercise_model.dart';
import 'package:apka_mgr/services/excercise/excercise_list_tile.dart';
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

    return ListView.builder(
      itemCount: excercisesSnapshot?.length ?? 0,
      itemBuilder: (context, index) {
        return ExcerciseListTile(excerciseModel: excercisesSnapshot![index]);
      },
    );
  }
}