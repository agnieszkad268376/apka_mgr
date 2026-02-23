import 'package:apka_mgr/models/excercise_model.dart';
import 'package:flutter/material.dart';

class ExcerciseListTile extends StatelessWidget {
  const ExcerciseListTile({super.key, required this.excerciseModel});
  final ExcerciseModel excerciseModel;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final titleFontSize = screenSize.height *0.025;
    final subtitleFontSize = screenSize.height * 0.015;

    DateTime dateTimeDate = excerciseModel.date;
    String dateDay = '${dateTimeDate.day}';
    if (dateDay.runes.length == 1){
      dateDay = '0$dateDay';
    }
    String dateMonth = '${dateTimeDate.month}';
    if (dateMonth.runes.length == 1){
      dateMonth = '0$dateMonth';
    }
    String date = '$dateDay.$dateMonth.${dateTimeDate.year}';

    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(date, style: TextStyle(fontSize: titleFontSize),),
          subtitle: Text(excerciseModel.description, style: TextStyle(fontSize: subtitleFontSize),),
        ),
      ),
    );
  }
}