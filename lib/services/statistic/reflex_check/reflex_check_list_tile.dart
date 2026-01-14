import 'package:apka_mgr/models/reflex_check_model.dart';
import 'package:flutter/material.dart';

class ReflexCheckListTile extends StatelessWidget {
  const ReflexCheckListTile({super.key, required this.reflexCheckModel});

  final ReflexCheckModel reflexCheckModel;

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
          title: Text('${reflexCheckModel.date}'),
          subtitle: Text('${reflexCheckModel.score}'),
        ),
      ), 
      );
  }
}