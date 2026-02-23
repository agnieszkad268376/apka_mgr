import 'package:apka_mgr/models/whack_a_mole_model.dart';
import 'package:flutter/material.dart';

class WhackAMoleListTile extends StatelessWidget {
  const WhackAMoleListTile({super.key, required this.whackAMoleModel});

  final WhackAMoleModel whackAMoleModel;

  @override
  Widget build(BuildContext context) {
    Color bgcolor = Color(0xFFFFFFFF);
    DateTime dateTimeDate = whackAMoleModel.date;
     String dateDay = '${dateTimeDate.day}';
    if (dateDay.runes.length == 1){
      dateDay = '0$dateDay';
    }
    String dateMonth = '${dateTimeDate.month}';
    if (dateMonth.runes.length == 1){
      dateMonth = '0$dateMonth';
    }
    String date = '$dateDay.$dateMonth.${dateTimeDate.year}';
    final screenSize = MediaQuery.of(context).size;
    final fontSizeTitle = screenSize.height * 0.025;
    final fontSizeSubtitle = screenSize.height *0.015;

    if (whackAMoleModel.level == '1') {
      bgcolor =  Color(0xFF4DBE9C);
    } else if (whackAMoleModel.level == '2') {
      bgcolor =  Color(0xFF4996BD);
    } else {
      bgcolor =  Color(0xFF9E579E);
    }
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: SizedBox(
            height: screenSize.height * 0.085,
            width: screenSize.height * 0.085,
            child: CircleAvatar(
              radius: 25.0,
              backgroundColor: bgcolor,
            ),
          ),
          title: Text(date, style: TextStyle(fontSize: fontSizeTitle ),),
          subtitle: Text('Wynik gry: ${whackAMoleModel.score} punkty\n'
                         'Pudła: ${whackAMoleModel.missedHits}',
                         style: TextStyle(fontSize: fontSizeSubtitle ),),
        ),
      ),
    );
  }
}