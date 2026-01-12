import 'package:apka_mgr/models/dot_controller_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DotControllerList extends StatefulWidget {
  const DotControllerList({super.key});

  @override
  State<DotControllerList> createState() => _DotControllerListState();
}

class _DotControllerListState extends State<DotControllerList> {
  @override
  Widget build(BuildContext context) {
    final dotControllerSnapshot = Provider.of<List<DotControllerModel>?>(context);

    return ListView.builder(
      itemCount: dotControllerSnapshot?.length ?? 0,
      itemBuilder: (context, index) {
        final dotControllerStat = dotControllerSnapshot?[index];
        return ListTile(
          title: Text('Data: ${dotControllerStat!.date}'),
          subtitle: Text('Wynik ${dotControllerStat.score}'),
        );
      }
    );
  }
}