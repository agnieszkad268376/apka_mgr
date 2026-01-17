import 'package:apka_mgr/models/build_a_word_model.dart';
import 'package:flutter/material.dart';

class BuildAWordListTile extends StatelessWidget {
  const BuildAWordListTile({super.key, required this.buildAWordModel});

  final BuildAWordModel buildAWordModel;

  @override
  Widget build(BuildContext context) {

    Color bgcolor = Color(0xFFFFFFFF);
    DateTime dateTimeDate = buildAWordModel.date;
    String date = '${dateTimeDate.day}.${dateTimeDate.month}.${dateTimeDate.year}.';
    final screenSize = MediaQuery.of(context).size;
    final fontSizeTitle = screenSize.height * 0.025;
    final fontSizeSubtitle = screenSize.height *0.015;
    String level = "łatwy";

    if (buildAWordModel.level == 'easy') {
      bgcolor =  Color(0xFF4DBE9C);
      level = "łatwy";
    } else if (buildAWordModel.level == 'medium') {
      bgcolor =  Color(0xFF4996BD);
      level = "średni";
    } else {
      bgcolor =  Color(0xFF9E579E);
      level = "trudny";
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: bgcolor,
          ),
          title: Text(date, style: TextStyle(fontSize: fontSizeTitle),),
          subtitle: Text('Wynik: ${buildAWordModel.score} punkty \n'
                         'Poziom słów: $level \n'
                         'Ilość błędów: ${buildAWordModel.missedLetters} \n',
                         style: TextStyle(fontSize: fontSizeSubtitle),
        ),
      ), 
      ),
    );
  }
}