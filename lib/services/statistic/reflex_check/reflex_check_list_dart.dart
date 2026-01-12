import 'package:apka_mgr/models/reflex_check_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReflexCheckListDart extends StatefulWidget {
  const ReflexCheckListDart({super.key});

  @override
  State<ReflexCheckListDart> createState() => _ReflexCheckListDartState();
}

class _ReflexCheckListDartState extends State<ReflexCheckListDart> {
  @override
  Widget build(BuildContext context) {
    final reflexCheckSnapshot = Provider.of<List<ReflexCheckModel>?>(context);

    return ListView.builder(
      itemCount: reflexCheckSnapshot?.length ?? 0,
      itemBuilder: (context, index) {
        final reflexCheckStat = reflexCheckSnapshot?[index];
        return ListTile(
          title: Text('Data: ${reflexCheckStat!.date}'),
          subtitle: Text('Wynik ${reflexCheckStat.score}'),
        );
      }
    );
  }
}