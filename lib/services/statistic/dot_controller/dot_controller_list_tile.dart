 import 'package:apka_mgr/models/dot_controller_model.dart';
import 'package:flutter/material.dart';

class DotControllerListTile extends StatelessWidget {
  const DotControllerListTile({super.key, required this.dotControllerModel});

  final DotControllerModel dotControllerModel;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Color(0xFFFFFFFF),
          ),
          title: Text('${dotControllerModel.date}'),
          subtitle: Text('${dotControllerModel.score}'),
        ),
      ), 
      );
  }
}