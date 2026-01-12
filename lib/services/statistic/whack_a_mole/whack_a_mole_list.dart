import 'package:apka_mgr/models/whack_a_mole_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WhackAMoleList extends StatefulWidget {
  const WhackAMoleList({super.key});

  @override
  State<WhackAMoleList> createState() => _WhackAMoleListState();
}

class _WhackAMoleListState extends State<WhackAMoleList> {
  @override
  Widget build(BuildContext context) {
    final whackAMoleSnapshot = Provider.of<List<WhackAMoleModel>?>(context);

    return ListView.builder(
      itemCount: whackAMoleSnapshot?.length ?? 0,
      itemBuilder: (context, index) {
        final whackAMoleStat = whackAMoleSnapshot?[index];
        return ListTile(
          title: Text('Data: ${whackAMoleStat!.date}'),
          subtitle: Text('Wynik ${whackAMoleStat.score}'),
        );
      }
    );
  }
}