 import 'package:apka_mgr/models/dot_controller_model.dart';
import 'package:flutter/material.dart';

class DotControllerListTile extends StatelessWidget {
  const DotControllerListTile({super.key, required this.dotControllerModel});

  final DotControllerModel dotControllerModel;

  @override
  Widget build(BuildContext context) {
    Color bgcolor = Color(0xFFFFFFFF);
    DateTime dateTimeDate = dotControllerModel.date;
    String date = '${dateTimeDate.day}.${dateTimeDate.month}.${dateTimeDate.year}.';
    final screenSize = MediaQuery.of(context).size;
    final fontSizeTitle = screenSize.height * 0.025;
    final fontSizeSubtitle = screenSize.height *0.015;
    int missedDots = int.parse(dotControllerModel.missedDots);
    double correctDots = (dotControllerModel.score + missedDots)/2;
    int time = 0;

    if (dotControllerModel.controlledDots == '1') {
      bgcolor =  Color.fromARGB(255, 177, 190, 77);
    } else if (dotControllerModel.controlledDots == '2') {
      bgcolor =  Color.fromARGB(255, 73, 189, 135);
    } else if (dotControllerModel.controlledDots == '3') {
      bgcolor =  Color.fromARGB(255, 83, 124, 220);
    }else if (dotControllerModel.controlledDots == '4') {
      bgcolor =  Color.fromARGB(255, 128, 119, 231);
    } else {
      bgcolor =  Color(0xFF9E579E);
    }

    if (dotControllerModel.level == 'easy') {
      time = 15;
    } else if (dotControllerModel.level == 'medium') {
      time = 30;
    } else {
      time = 60;
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
          title: Text(date, style: TextStyle(fontSize: fontSizeTitle),),
          subtitle: Text('Wynik: ${dotControllerModel.score} punkty \n'
                         'Wkazano poprawnie $correctDots z ${dotControllerModel.controlledDots} \n'
                         'Czas gry: $time s \n',
                         style: TextStyle(fontSize: fontSizeSubtitle),),
        ),
      ), 
      );
  }
}