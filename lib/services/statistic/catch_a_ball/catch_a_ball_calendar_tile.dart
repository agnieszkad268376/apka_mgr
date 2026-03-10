import 'package:apka_mgr/models/catch_a_ball_model.dart';
import 'package:flutter/material.dart';

class CatchABallCalendarTile extends StatelessWidget {
  const CatchABallCalendarTile({super.key, required this.catchABallModel});

  final CatchABallModel catchABallModel;

  @override
  Widget build(BuildContext context) {

    Color bgcolor = Color(0xFFFFFFFF);    
    
    final screenSize = MediaQuery.of(context).size;
    final fontSizeTitle = screenSize.height * 0.02;
    final fontSizeSubtitle = screenSize.height *0.015;

    if (catchABallModel.numberOfBalls == 10) {
      bgcolor =  Color(0xFF4DBE9C);
    } else if (catchABallModel.numberOfBalls == 15) {
      bgcolor =  Color(0xFF4996BD);
    } else {
      bgcolor =  Color(0xFF9E579E);
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
          title: Text('Wynik: ${catchABallModel.score} punkty', style: TextStyle(fontSize: fontSizeTitle),),
          subtitle: Text('Dokładne wskazania piłki: ${catchABallModel.preciseHits} \n'
                         'Niedokładne wskazanie piłki: ${catchABallModel.impreciseHits} punkty \n'
                         'Czas: ${catchABallModel.time} s \n',
                         style: TextStyle(fontSize: fontSizeSubtitle),),
        ),
      ), 
      );
  }
}