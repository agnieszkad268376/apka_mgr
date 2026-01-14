import 'package:apka_mgr/models/catch_a_ball_model.dart';
import 'package:apka_mgr/services/statistic/catch_a_ball/catch_a_ball_list_tile.dart';
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
        return CatchABallListTile(catchABallModel: catchABallSnapshot![index]);
      });
  } 
}