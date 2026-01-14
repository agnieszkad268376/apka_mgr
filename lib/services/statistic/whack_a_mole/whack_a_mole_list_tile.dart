import 'package:apka_mgr/models/whack_a_mole_model.dart';
import 'package:flutter/material.dart';

class WhackAMoleListTile extends StatelessWidget {
  const WhackAMoleListTile({super.key, required this.whackAMoleModel});

  final WhackAMoleModel whackAMoleModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Color(0xFFFFFFFF),
          ),
          title: Text('${whackAMoleModel.date}'),
          subtitle: Text('${whackAMoleModel.score}'),
        ),
      ), 
      );
  }
}