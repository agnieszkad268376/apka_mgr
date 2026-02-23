import 'package:apka_mgr/models/catch_a_ball_model.dart';
import 'package:apka_mgr/services/statistic/catch_a_ball/catch_a_ball_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum BallFilter {easy, medium, hard, all}

class CatchABallList extends StatefulWidget {
  const CatchABallList({super.key});

  @override
  State<CatchABallList> createState() => _CatchABallListState();
}

class _CatchABallListState extends State<CatchABallList> {
  BallFilter _selectedBallNumber = BallFilter.all;

  @override
  Widget build(BuildContext context) {
    final catchABallSnapshot = Provider.of<List<CatchABallModel>?>(context);

    if (catchABallSnapshot == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredData = _filterData(catchABallSnapshot);

    return Column(
      children: [
        _buildFilterButtons(),
        Expanded(
          child: ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              return CatchABallListTile(
                catchABallModel: filteredData[index],
              );
            },
          ),
        ),
      ],
    );
  }

  
  List<CatchABallModel> _filterData(List<CatchABallModel> data) {
    switch (_selectedBallNumber) {
      case BallFilter.easy:
        return data.where((e) => e.numberOfBalls == 10).toList();
      case BallFilter.medium:
        return data.where((e) => e.numberOfBalls == 15).toList();
      case BallFilter.hard:
        return data.where((e) => e.numberOfBalls > 15).toList();
      case BallFilter.all:
        return data;
    }
  }

  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        children: [
          _chip("Wszystkie", BallFilter.all),
          _chip("10 piłek", BallFilter.easy),
          _chip("15 piłek", BallFilter.medium),
          _chip("20 piłek", BallFilter.hard),
        ],
      ),
    );
  }

  Widget _chip(String label, BallFilter level) {
    final screenSize = MediaQuery.of(context).size;
    Color bgColor;

    if (level == BallFilter.easy) {
      bgColor =  Color(0xFF4DBE9C);
    } else if (level == BallFilter.medium) {
      bgColor = Color(0xFF4996BD);
    } else if (level == BallFilter.hard) {
      bgColor = Color(0xFF9E579E);
    } else {
      bgColor = Color.fromARGB(255, 55, 55, 55);
    }
    
    return ChoiceChip(
      label: SizedBox(
        width: screenSize.width * 0.15,
        height: screenSize.height * 0.02,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundColor: bgColor,
            ),
            Text(label, style: TextStyle(fontSize: screenSize.height * 0.012)),
          ],
        ),
      ),
      selected: _selectedBallNumber == level,
      onSelected: (_) {
        setState(() => _selectedBallNumber = level);
      },
    );
  }
}



