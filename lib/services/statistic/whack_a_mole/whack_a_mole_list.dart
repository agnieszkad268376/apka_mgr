import 'package:apka_mgr/models/whack_a_mole_model.dart';
import 'package:apka_mgr/services/statistic/whack_a_mole/whack_a_mole_list_tile.dart';
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
        return WhackAMoleListTile(whackAMoleModel: whackAMoleSnapshot![index]);
      }
    );
  }
}