import 'package:apka_mgr/models/catch_a_ball_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatchABallList extends StatefulWidget {
  const CatchABallList({super.key});

  @override
  State<CatchABallList> createState() => _CatchABallListState();
}

class _CatchABallListState extends State<CatchABallList> {
  @override
  Widget build(BuildContext context) {
    final catchABallSnapshot = Provider.of<List<CatchABallModel>?>(context);
    
    return ListView.builder(
      itemCount: catchABallSnapshot?.length ?? 0,
      itemBuilder: (context, index){
        final catchABallStat = catchABallSnapshot?[index];
        return ListTile(
          title: Text('Data ${catchABallStat!.date}'),
          subtitle: Text('Wynik ${catchABallStat.score}'),
        );
      });
  }
}