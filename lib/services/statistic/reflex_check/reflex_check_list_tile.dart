import 'package:apka_mgr/models/reflex_check_model.dart';
import 'package:flutter/material.dart';

class ReflexCheckListTile extends StatelessWidget {
  const ReflexCheckListTile({super.key, required this.reflexCheckModel});

  final ReflexCheckModel reflexCheckModel;

  @override
  Widget build(BuildContext context) {
    Color bgcolor = Color(0xFFFFFFFF);
    DateTime dateTimeDate = reflexCheckModel.date;
    String date = '${dateTimeDate.day}.${dateTimeDate.month}.${dateTimeDate.year}.';

    if (reflexCheckModel.roundsPlayed == 3) {
      bgcolor =  Color(0xFF4DBE9C);
    } else if (reflexCheckModel.roundsPlayed == 5) {
      bgcolor =  Color(0xFF4996BD);
    } else {
      bgcolor =  Color(0xFF9E579E);
    }

    return  Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: bgcolor,
          ),
          title: Text(date),
          subtitle: Text('${reflexCheckModel.score}'),
        ),
      ), 
      );
  }
}