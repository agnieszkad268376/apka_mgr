import 'package:apka_mgr/models/whack_a_mole_model.dart';
import 'package:flutter/material.dart';

class WhackAMoleCalendarTile extends StatelessWidget {
  const WhackAMoleCalendarTile({super.key, required this.whackAMoleModel});

  final WhackAMoleModel whackAMoleModel;

  @override
  Widget build(BuildContext context) {
    Color bgcolor = Color(0xFFFFFFFF);
    
    final screenSize = MediaQuery.of(context).size;
    final fontSizeTitle = screenSize.height * 0.02;
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
          title: Text('Wynik gry: ${whackAMoleModel.score} punkty', style: TextStyle(fontSize: fontSizeTitle ),),
          subtitle: Text('Wynik gry: ${whackAMoleModel.score} punkty\n'
                         'Pudła: ${whackAMoleModel.missedHits}',
                         style: TextStyle(fontSize: fontSizeSubtitle ),),
        ),
      ),
    );
  }
}