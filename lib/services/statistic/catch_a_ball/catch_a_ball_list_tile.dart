import 'package:apka_mgr/models/catch_a_ball_model.dart';
import 'package:flutter/material.dart';

class CatchABallListTile extends StatelessWidget {
  const CatchABallListTile({super.key, required this.catchABallModel});

  final CatchABallModel catchABallModel;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Color(0xFFFFFFFF),
          ),
          title: Text('${catchABallModel.date}'),
          subtitle: Text('${catchABallModel.score}'),
        ),
      ), 
      );
  }
}