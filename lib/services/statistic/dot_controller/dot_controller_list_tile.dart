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
          subtitle: Text('${dotControllerModel.score}'),
        ),
      ), 
      );
  }
}